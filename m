Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99526B0380
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjCHJ6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCHJ6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:58:02 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C197D59E7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:57:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l1so16035173pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 01:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678269475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szwudWjVCqo4cXsa2hswtbiIZUYiHlCdLL/iW8bEO1U=;
        b=WG/vcp/z8JCrNYARIQWbnJKgXCe6jPX3ROGsNRDLqCrY+q+mNYVRwOh93r4NysSCur
         /i+yf9ksMbImlbkysEN61FGLUHU7RGy6o2u34kaCY8EIMqiS5WzywSiQIeIzJv7CfQbM
         h8TVdpOZLxx8HHMtXNelXJr2sIs9WefCMrZZpjTmis29dTmmNlpZ05ChnJXWmuV0p9SO
         OpWQmb9cMzaLb3SWAUDSevU4CaBQZ3/OeQJXZKyx5scQZhYrIR5SglKORy4vHvbeBBMB
         /uL8TfPp2c55ga+2tV3uymzU28OGNb642Y/23NCmaTS1zPUCpTKwZMEwGu1SVCPiClif
         kP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678269475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szwudWjVCqo4cXsa2hswtbiIZUYiHlCdLL/iW8bEO1U=;
        b=sJFzAi+3le5RXz+KFwFR1srw6Kd2Y/WQj5Pt2Jq/EGG1WlfkdmRC6j2rBvOJVdWg+f
         yBlzQapqp4AmaII6iN1BvNNq5Z0Vt4Ym9l90/7stCmimusu8idGs+4R29DKVyH6UIzTO
         L+AmTFJ7g4x8FWY517EAi7lSogEUHlh+O9BwkHXXBKNejylhmzEkxhCUYwADapro8aZJ
         Px5n6Hssj0k3yNwWOr4FLKzqgdkIQnWYVE/7CFFKqIAVQdTetllcu2VfZnnQPMig+DqV
         UNHfBXv7oKJd6lAjYbY1cCEt+8uH5yqUvZDH3mlDt4waIoO1AXyxajVdpSerzH1c9qm3
         QYeA==
X-Gm-Message-State: AO0yUKWbHzipp3Hs8ANcvwS2j4TYWnyKq4fsZl6MiSUhVlZpurOMPppH
        uRZwRMtgeVM9tTEoSfMosJgltOgBejj06HAMpeI/wA==
X-Google-Smtp-Source: AK7set9iLU2oX6cC5DQYkh/uXudtH93SfREwiK9iB3b07Pi9mxKR2D/1nKL3giDRGz4X8ROvT9TUtfpXGSenG+wXMpM=
X-Received: by 2002:a17:902:efcf:b0:19c:3296:ecdc with SMTP id
 ja15-20020a170902efcf00b0019c3296ecdcmr6813306plb.1.1678269475249; Wed, 08
 Mar 2023 01:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20230308011705.291337-1-konrad.dybcio@linaro.org>
In-Reply-To: <20230308011705.291337-1-konrad.dybcio@linaro.org>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Wed, 8 Mar 2023 17:57:43 +0800
Message-ID: <CAAQ0ZWQDfZBcQuuVOjUWd1s=uTwXyj6qvQCw6=1qbywd2XcnVQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Allow #power-domain-cells
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 9:17=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro.=
org> wrote:
>
> MPM provides a single genpd. Allow #power-domain-cells =3D <0>.
>
> Fixes: 54fc9851c0e0 ("dt-bindings: interrupt-controller: Add Qualcomm MPM=
 support")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

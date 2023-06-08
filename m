Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF034728652
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbjFHR1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbjFHR1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:27:12 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6FF2D68
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:27:07 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-75ea05150b3so72215885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686245226; x=1688837226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4iHIyxI1wD4Umf7hLNGOpALbyhbydhr+kR4iE7/CAzc=;
        b=Md59kBzOyPnMy+yguKEc2jnP2maIe8uzD/sWHmft4wKLdLD9cADn0DLgTIUv4bt8Xm
         6uXG4u1Y3eTWZW2KY0X5rf3FIgdg66UpoK9YZLsMWNAvW7ZxMFe0fvOxj0q1EqSnqE1B
         f762gyDVXPb3vutgnLs5+poK5+I2U2uqIsgFYbn5q1o33fu6NAkG/An8tJcrj7LELMeQ
         uPyTJtzFgqRTiTzrjhHK3gjySR4rgEZyMp8tbJf+d4fD3tzBxNt7ik3R0NZwnppaPEgR
         qvxmmCn9GYC1WdrNTn8MG5V4XvnUHrQFumZoImXtyu0FMZk7S9QdrCVSikxzq0All6g8
         8pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686245226; x=1688837226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iHIyxI1wD4Umf7hLNGOpALbyhbydhr+kR4iE7/CAzc=;
        b=JBHFwbVdjDAAvS49uJxgoPB75BNk0QxbKfe/TYb/1MDGT6OStkt8oZrpnjzC+nkOtp
         ZtfWxid+PSta5d/4cP5AbySJh+SKh5wxfk/cHskQ5zZyKMG01Dog3RG85TIxxPBkKtws
         Hiu1Nooa9qxy/F3Ad6MOViXbD0WHuTz2JL1DQvXQp7WkN9NV6UtioV1Swk8FOmQqRjUx
         TGQwtjZteYOpHmI92TAxIsv8RVBDsgFUpNuoHUgHpwYvy6Y0wugQtfSL66az1MwScW0Z
         /Vs+/J8SQvx+/QKkU72MFoHdG/0W+Krukd1BeZtCFnnElEnqbKnGN5DpY5o3huywivJA
         LSCg==
X-Gm-Message-State: AC+VfDwcMxO3OnBU+XL7iwkYYXAy1HVvegOgjqrPqjZfaOoRq3GhQnJu
        Ciz/WbwGWMMIlo0PU9dqm5gHqvwKcRvclDLwLkFN1g==
X-Google-Smtp-Source: ACHHUZ5hEP2TkSwruLFkZaYNvidX+ZAt7xPw6PU8FwgM974sDzsLhrEMTzEiKmEiaJHuZ5U/2BRrbRjXWqRO3kh9Slc=
X-Received: by 2002:a05:6214:2688:b0:626:e55:dfb2 with SMTP id
 gm8-20020a056214268800b006260e55dfb2mr2730635qvb.39.1686245226103; Thu, 08
 Jun 2023 10:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230602161246.1855448-1-amit.pundir@linaro.org>
 <CAD=FV=U9xwxC4+wDYFMSoLWaj8vaLH_jettZ=nxEZP+1tNk=oA@mail.gmail.com>
 <d0dfdfba-7a70-7d12-2c30-ad32b3f95bb8@linaro.org> <CAMi1Hd1Upo8zV4MPtdqHgEaMQ72yK0gZgf5Z4uOaqKqhw8Hndg@mail.gmail.com>
 <55f07600-3fa5-f3c2-eb3e-e87a57244812@linaro.org>
In-Reply-To: <55f07600-3fa5-f3c2-eb3e-e87a57244812@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 8 Jun 2023 22:56:28 +0530
Message-ID: <CAMi1Hd0qRrRw3_U7kqz-8BJnwJR1RqweajBWrZWWDGmtqVMDAQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Move LVS regulator nodes up
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        regressions <regressions@lists.linux.dev>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 at 15:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
>
> The problem looks like in missing consumers, missing probe dependencies
> or something in the driver how it handles these.

Missing consumers seem to be the case here, if I'm reading the
$debugfs/regulator/regulator_summary correctly(?)
https://www.irccloud.com/pastebin/raw/2jwn0EQw.
lvs1 and lvs2 sysfs entries in /sys/class/regulator/ do not list any
consumers explicitly either.

Regards,
Amit Pundir


>
> DTS should not be used for solving OS related problems.
>
> Best regards,
> Krzysztof
>

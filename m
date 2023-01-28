Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F247567F701
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjA1KSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjA1KSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:18:01 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291AC199D6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:18:00 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h12so7030722wrv.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5D25Xdl9yRHOjlDCwuo0QnIFiab44vN7z8Kgt25hgE=;
        b=tJ2TnjNQS/WY9Iowoo+AStfZmIqqsxbyZ7SLhrKsoltvweZa62ydYbM2mPUGJoSJVc
         xxwVyDwWZVyJ/8Cmv/N+0EXiI0TmRYEgfm1TMjFQyTKwxTgYMomfKjlzMa/oJv4B88VU
         t7Io2B+Bdr6CWlZQ/JL3TUSyuOX3/q5SPXO9c9cCJcK1j//6zRSnelHQrU29eJJCC8Qv
         dpPITECmAFA2j7O/yRG48SHjAs0lC7o2uzt8RjmQ4jbRs5s6w2kOle+6/51ILgpp6TAA
         30Q7jncYl5gbGEshAO791CBiisnXzE55Jpy9l7rPBMpGDxctGflpkw+aOhGTQPsXk05H
         SNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5D25Xdl9yRHOjlDCwuo0QnIFiab44vN7z8Kgt25hgE=;
        b=njyfPow4CGMCzsv51VWv3okD7fV7EQXH5eG1H+o7OLyte30VzeMasxGvkbH9n7Emmd
         sbof1nguBfCy1faC04EQk32GDH0AxvrWjEPQthCntLG5El5EaNdKk/7rYX0hhiqP0dRm
         o7KDujBbhXN+OMWoysef4W+8I6wB1QaJejTuqhUNxGtwzL8iRZOWqCDb9hy8IeVUIhc0
         LcZJZHl3KtFyMg9/dzV1JX8XoJb/qktbZRAkBTOc1kO6ERab4Drgsx26AnCIAXF2/nuK
         KQRZk8ss8BnC7l8u4FVZ+uwldcHWlblWO2rKWgulft37BysONftA9DsMSeCeMTNv/BHm
         J1RA==
X-Gm-Message-State: AO0yUKWTgycrRkdFWxrD7ALpvcIg89lM7Vwh7tLOdMZklncMasnKCA5i
        vtn/ZTUjo51lbATi+iX4c3gYow==
X-Google-Smtp-Source: AK7set/KnPgjGWF1aQBcNompbSrxpus9U4yPrXiimVQM6FtpRxWY124FW8YXdvaF9MDfw3yu9rDVPg==
X-Received: by 2002:a5d:5274:0:b0:2bf:e2bf:c4ea with SMTP id l20-20020a5d5274000000b002bfe2bfc4eamr443580wrc.35.1674901078648;
        Sat, 28 Jan 2023 02:17:58 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z4-20020adfd0c4000000b002bdc3f5945dsm6112812wrh.89.2023.01.28.02.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 02:17:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: apm: use "okay" for status
Date:   Sat, 28 Jan 2023 11:17:53 +0100
Message-Id: <167490104050.6514.6539497719115099171.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127101827.93728-1-krzysztof.kozlowski@linaro.org>
References: <20230127101827.93728-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 11:18:27 +0100, Krzysztof Kozlowski wrote:
> "okay" over "ok" is preferred for status property.
> 
> 

Applied, thanks!

Let me know if anyone preferred to take it via sub-arch/SoC maintainer tree.
I'll drop it then.

[1/1] arm64: dts: apm: use "okay" for status
      https://git.kernel.org/krzk/linux-dt/c/2f3086577f41a4569de4842049bff12f0926b71b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

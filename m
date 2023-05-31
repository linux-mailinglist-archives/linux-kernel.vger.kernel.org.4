Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58AB7173E3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjEaCtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjEaCtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:49:12 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73008E;
        Tue, 30 May 2023 19:49:09 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6260b578097so24649216d6.3;
        Tue, 30 May 2023 19:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685501349; x=1688093349;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e2j8yrS747eKvqEmOM0dcXUIRaD3dt4RVORVnxHAYs=;
        b=qqoBPw/WY+2FSw0nXRa+1jy91yIpTrEAKJn/AOAlD4lvNgY41wlUGC1SkH33Dr2KYk
         KB7VP94bPoNbN5qG3iVHTh5itAUJ1sVKSajgrsV3iHinQbx20UGDrK4siNz69pSbHY8O
         UmpV9E68jVUyZS2NErYZeeyyN5gz2SYBb5yNReN2Rzt7u6eOp7P7saURYQxdRMN1mFjl
         oadzzPD2eJlK9BS+Wb/VMSQmx3NpgrMhNsYfPRPPny3ZUbmYT2n/5qy0YdcWP/i7B0My
         5LzvvzD2GEfVfpahepLUzKG1+OCrZZR5NzqlrXAxQqSGAEwSNDdzHdLmX+9oVMrGroYQ
         gBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685501349; x=1688093349;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6e2j8yrS747eKvqEmOM0dcXUIRaD3dt4RVORVnxHAYs=;
        b=P2sklf2J8quSsHiyojSPqB1XE9OyvR9Wywj7P6LfsMPmEkkBfWP1wZ3eHdU6GbiZiO
         1BkjGfgk+7PhxNxsNrJ/DOwmlBQTxLI6L+rRNe+DrQ+cboOpQSkqoltTwQXU//bWFuRC
         GouVmc6UAoNg/Dnm4dLFpE3izbZ5xJSdkEzwsgOq98aZk9Ym8L48xfBCymonqrK5G5BX
         YCaNLOfVQyBqAuhZC/jbYneTeCafI4AgArgHO9lA+OLvhXvSCfggvmAnenlpgC5PVZOp
         XUShfLYKjSgwsvoip2lojG34UjNOdjUQXM2GVYqv86VJO31B8tMV0nqVfBEVw6OpS7pT
         LhoA==
X-Gm-Message-State: AC+VfDxyTunxj3AFdZin+v+nN+DHr/aZwjHRmUKRyWjanzf7dxdxBmb8
        ZIdEpovLYYOcvP9tNd3f+Ck4sJ4hszinQA==
X-Google-Smtp-Source: ACHHUZ52Yw/1OjG4IhoiE6fZ7eKnLRhYKO0DIKGAauUkEl9PmXjiQG87Tlv0PJ/4VoneEdbKSvFcUA==
X-Received: by 2002:a05:6214:412:b0:625:9562:f04 with SMTP id z18-20020a056214041200b0062595620f04mr4884729qvx.51.1685501348941;
        Tue, 30 May 2023 19:49:08 -0700 (PDT)
Received: from localhost ([2600:4040:2007:9800:dcb4:7fef:9d6a:e79f])
        by smtp.gmail.com with ESMTPSA id er5-20020a056214190500b006262956aa0dsm1952230qvb.99.2023.05.30.19.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 19:49:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 30 May 2023 22:49:07 -0400
Message-Id: <CT04D1K5GOBT.29Y5DO5HHS57V@Latitude-E6420>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, "Olof Johansson" <olof@lixom.net>,
        <soc@kernel.org>
Cc:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: Add qcom,usb-hs-phy-msm8960
From:   "Rudraksha Gupta" <guptarud@gmail.com>
X-Mailer: aerc 0.8.2
References: <20230527040905.stmnoshkdqgiaex6@ripper>
 <20230528001010.47868-3-guptarud@gmail.com>
 <fb65244e-ab3b-c473-57b9-2da80e67be4a@linaro.org>
In-Reply-To: <fb65244e-ab3b-c473-57b9-2da80e67be4a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue May 30, 2023 at 9:22 AM EDT, Krzysztof Kozlowski wrote:
> On 28/05/2023 02:10, Rudraksha Gupta wrote:
> > Adds qcom,usb-hs-phy-msm8960 compatible
> >=20
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
>
> Best regards,
> Krzysztof

It seems like "dt-bindings:" is the subject prefix for this file. Would
you like me to use another prefix instead?

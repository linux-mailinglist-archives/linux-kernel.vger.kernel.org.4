Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3A7742597
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjF2MTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjF2MTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:19:40 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1DF1BE8;
        Thu, 29 Jun 2023 05:19:39 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-78f554d4949so201208241.3;
        Thu, 29 Jun 2023 05:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688041179; x=1690633179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TGv78mKGzB1Ok9tyfdClls4DVuXjLXhxTceQ76I/LfY=;
        b=RV1lqe1xUgZ170NuxsH+Zfi6fdVox6x1HcE5zlTgTdOOf+DwUdy6UhEleH1Yiyqi/B
         qwV8T/rZRq7Bl+yOrz0+an491UMneurdnbcq42CjpAUGoLcNM/2sg7dmTgsgSJ50TUE5
         a7TaS8GXWBQ2hK4oVtvkEyc4utf5efp2og9SvsmQhXe0beL/0cFflVJ9Flr8LU0BQQLx
         vk8lpYgyDk4YtjiIMtWw4mKTzBCm33gX+dq3DjBbIdTLIAGhDtm1FuXzvuMVBUIbgHV9
         9CUtrttt9LTRnfuxxJHV0IKoZtAvL32vMVoROfqm5kmS3L5UzrJfqnfyFQhl+ayPIls4
         tTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688041179; x=1690633179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGv78mKGzB1Ok9tyfdClls4DVuXjLXhxTceQ76I/LfY=;
        b=hQJNEM6kWwQy7xmNUvc3T7pYT7Oq7wpuajBk+MGGNUTWTW8aHZZ/ImmZQfRyzspyCB
         4MlGlT8lKHR1Yy5/He6dOjyQmScezD+U7/dR5JklfP3CxQ1ALQGqaBS7j3Mx+WetPoZV
         Cb9pg40LnbweSoaMmyyIQ0BjFmAzDdZawfaZDpLWcb3NxkYTNmHyle9Ki49rZ/n8J50E
         JJL5P0HfQo3OG3+znmZdm+Ctd8ORdvxyjHFt6B1E6MJ372W2YFz5yMu7jZjWxlAv84f8
         2j34vQnIHzWHwiatHiHAJ2VS1mV31a4ZDs9QfgDAf7XcnSFZIBrTPVNFvtYcPI3CRMGT
         oZ5A==
X-Gm-Message-State: AC+VfDyvubhGffduUNJ77n7kxDIT+eiTiZz5MYRvanH41cSKx1W6wnnr
        uTjNzY7rhpuCJQbrYgjAG7+p6nkPQQRWSeWytps=
X-Google-Smtp-Source: ACHHUZ6v6+1aaPN/DZCIV2mVThVjW3Ef7xPdSSOAu5cyWd8b4TbcBikkHfY5x7c4ThKdZr4KjZhxvpm+j5T7sx/1v6s=
X-Received: by 2002:a67:ea8f:0:b0:443:6b64:aed4 with SMTP id
 f15-20020a67ea8f000000b004436b64aed4mr7137772vso.26.1688041178729; Thu, 29
 Jun 2023 05:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230207091902.2512905-1-milkfafa@gmail.com> <20230207091902.2512905-4-milkfafa@gmail.com>
 <867ec517-ef29-e8ac-8e0c-6f7ca440cf3d@linaro.org> <CADnNmFpf8kMeHYrUcab5Mg3P0zZ=kUi3o8bLCz-EdyAHVKoLNw@mail.gmail.com>
 <c4676e35-322c-7091-65d0-4e50ba04ca85@xs4all.nl>
In-Reply-To: <c4676e35-322c-7091-65d0-4e50ba04ca85@xs4all.nl>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Thu, 29 Jun 2023 20:19:27 +0800
Message-ID: <CADnNmFrw08stAZ8BvpP7y6EyrG7Dd_UQ9em8QqvghVLQmQmwdQ@mail.gmail.com>
Subject: Re: [PATCH v11 3/7] dt-bindings: arm: nuvoton: Add NPCM GFXI
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mchehab@kernel.org, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrzej.p@collabora.com,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Sorry for the late response.


> > I'll move it to Documentation/devicetree/bindings/soc/npcm/nuvoton,gfxi.yaml.
>
> v12 still has this in the old location, so it appears you forgot this.

Thanks for the reminder, v13 will correct the path.

Regards,
Marvin

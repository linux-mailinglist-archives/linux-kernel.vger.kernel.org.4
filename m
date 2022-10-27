Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E8760F0FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiJ0HNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiJ0HNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:13:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC4153E16;
        Thu, 27 Oct 2022 00:13:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n12so1933267eja.11;
        Thu, 27 Oct 2022 00:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MDxbGJrw6ODYsB7ZdyD4/84nlR1jBff/NV+grX5V3Bs=;
        b=Tz5mhNIF+/mpMprs4Y6gUBmDWkzyVobMrFo5/UU48sEYvCG2FuZ2moCLwMtBpu1uSk
         fckgdxFABiXavxRr7zTImcwYGTYN2MIY/gJRsxupEMvy5nJ/Q5r5MdR3qB3GLLRo14p/
         3rusLtUVUMllo4RQhR7IpNTOD2fLAWcFS+a8fFw6mIO60CBTPDyOurQnnTP+4vLZT6+G
         ttDQxem84uINniF9Ha279HH1ni9dtTODY7Fa6jZ51uMsvzMTfRBwQKWswy264TMs16pZ
         5ooze8s8MrIR0L+WDIVDVfKYYVglYkWDUn+CRk2ANAXvB+nLCRFjcjLDWOK0CikJBk+q
         uPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDxbGJrw6ODYsB7ZdyD4/84nlR1jBff/NV+grX5V3Bs=;
        b=GNav3QR0u93wUH0U5LbTSUoP60DS12piIVqrG/tykjl/CxwXAetZSEv6fcjvIB1Gxo
         4QoB52xtQgV3IlEUYXIzO+vLT41RaSuKbOqFQxc2Py5hmaRtZVW3DJu9WXIyIt5q6HzF
         +4RaRcn9EJ0jIVWQ2fQRIGJmmdUPL+LDPBZ0uLW/MeRbfL2d8qgFwpxPfa3wx0dSjd+2
         G/0qclEuC+nmPN6x/nTtzR5jEgMl0wHZK8fLDoXuNukIjhcrga6vT9Vs2PMW4S8DZ6SZ
         bpFXQ6qNdhRPDi8kSvIpX5087Rsq99er17xuP4a1W6D903Zm/XfGlU5sd1DRMFIFlgGg
         D2UQ==
X-Gm-Message-State: ACrzQf3jLUj6gQaJIthjV0jPhJclasJR+q84FdQr+jWYVV4LzS0vbAck
        DoOgIZDxyjgXrD0zQl1DlXy9n0ylONgfYw3eV80=
X-Google-Smtp-Source: AMsMyM7SJjmDy81uIp59EMVnOgbrq10xzO0jl74Jy5bcQqegFeZgsV1CK7dqzobdLEyH6QNX7eaGJJ3NXd7r0cBwTDQ=
X-Received: by 2002:a17:907:31c3:b0:770:852b:71a2 with SMTP id
 xf3-20020a17090731c300b00770852b71a2mr40960769ejb.557.1666854809089; Thu, 27
 Oct 2022 00:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221027060311.2549711-1-chancel.liu@nxp.com>
In-Reply-To: <20221027060311.2549711-1-chancel.liu@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 27 Oct 2022 10:13:17 +0300
Message-ID: <CAEnQRZAr9HQ6LNAdwOnvAKUrazr1Q0CognQfd-+67Sfo1zoOHw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for SAI on i.MX93 platform
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 9:14 AM Chancel Liu <chancel.liu@nxp.com> wrote:
>
> This patchset supports SAI on i.MX93 platform.
>
> Chancel Liu (3):
>   ASoC: dt-bindings: fsl,sai: Add compatible string for i.MX93 platform
>   ASoC: fsl_sai: Add support for i.MX93 platform
>   ASoC: fsl_sai: Specify the maxburst to 8 on i.MX93 platform

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5A16B1384
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCHVFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCHVFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:05:18 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AAC99C10;
        Wed,  8 Mar 2023 13:05:16 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-17638494edbso104597fac.10;
        Wed, 08 Mar 2023 13:05:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678309516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCrHtGbmJCKv3Di23qj+w9uSiDFBod+4MdcND44gbng=;
        b=TmkUlhcy4hFL7myQMLUBmr7KC7R8Lss/XHnqe7oFKOBGEjaqiL3N/iV0XrJ0fe5Qq2
         UpKsL9U4HjTOCKWCN3CvOuhDH1tWfrwfj1vfre2ptRwxCoE++NGO35w6ty29Bw2kxS+t
         Ylyc14t13yYWtK24tv5XyoNs19wlh5dmu57LBFuSHixFUWtERRVqWVfh7JviHViki/zr
         5nWwGNa3tZur6Rv9sZiA9LdJGNelwJxMNaFxH8DQRAHZ/K7/6RZWwIjpYtT6y+gB5vzv
         MwIQLAV1DkQwV078/M0MFn9gi8tUUavyrA2ifIdukAmdQedPTuFA3qX1KfoMLFCAMds0
         gMwA==
X-Gm-Message-State: AO0yUKX0FFbp2xOwlVMUyFy6enBOBTY0x6y5dFJqFyBjh857eynPpB02
        O/ZfDCRE3rE5xWWlH90kuQ==
X-Google-Smtp-Source: AK7set9/Ps1tTPEfBQh/bjTrnc2rNh9JcYy+t7gr1R/PqVzEvdsMO3AYJF6+ULl5+lHY9pOzR7oudA==
X-Received: by 2002:a05:6870:7011:b0:172:21eb:1c2d with SMTP id u17-20020a056870701100b0017221eb1c2dmr13152517oae.31.1678309516054;
        Wed, 08 Mar 2023 13:05:16 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n15-20020a4a848f000000b004f9cd1e42d3sm6490077oog.26.2023.03.08.13.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:05:15 -0800 (PST)
Received: (nullmailer pid 3796950 invoked by uid 1000);
        Wed, 08 Mar 2023 21:05:14 -0000
Date:   Wed, 8 Mar 2023 15:05:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: Re: [PATCH 09/20] dt-bindings: pinctrl: ralink: {mt7620,mt7621}:
 rename to mediatek
Message-ID: <20230308210514.GA3767521-robh@kernel.org>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
 <20230303002850.51858-10-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303002850.51858-10-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 03:28:38AM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> This platform from Ralink was acquired by MediaTek in 2011. Then, MediaTek
> introduced these SoCs which utilise this platform. Rename the schemas to
> mediatek to address the incorrect naming.

I said we don't do renames due to acquistions, you said that wasn't the 
reason, but then that's your reasoning here.

To give you another example, *new* i.MX things are still called 
'fsl,imx...' and it has been how many years since merging with NXP?

Rob

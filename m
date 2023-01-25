Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D01867B565
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbjAYPGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjAYPGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:06:02 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE7D40F4;
        Wed, 25 Jan 2023 07:06:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bk16so17345346wrb.11;
        Wed, 25 Jan 2023 07:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkSUqZWMeZKVzKhiXO+ME3iOU+7nVh8EOP2pS4JSDHk=;
        b=pm5Kt+1xFUjO+/tA1En5NnW+iB1X6cb+z6ws/fJ6yp+APi5QUPNO4lLdqZqYDvnAWF
         vmC79mW7hGuCNWaYgGrgh1ZiIBoN8f1k4dKsXgBDPvlP164J0sJ71+7kmsvY0CdLngdy
         r8pisUG+oEt3fi1mwBIuCKkR/KX5wHcjaaLt9lLHtrzXyYM9dub9gTKwAD76luR+gzpA
         fRwk4Qfmr7qKD8yb6/fHCT+h8ne5LV0NVrTwJ6xyIto8/5FqfOqdeKzy65sPBzM4HIRP
         yp1jj5aSSjcKmNdviyVZzT4ByG48E3Yj0I9eIUBsjoZu/50zgE3Mnniiichq+vo7eFrd
         /1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkSUqZWMeZKVzKhiXO+ME3iOU+7nVh8EOP2pS4JSDHk=;
        b=g/fwJRzeRHSZVwpQafcdfep8RoO086PPzVRjiuZsNRXzhqC+07b9xKTJ8VpwB0hyIm
         0A4eswiI3rBHz5N0auxZqjgF5sgb8J+A33faFURIWs+MKKxhcjO+TObL4CNsn4SbrZ55
         jcX28jyGyEk3om/tg9aVetuL+M5sM03WrsMPArfxs2/U930IFlu6zLn0bkMlnWY9ZDV1
         JL1MUtMS9gzJg5Xb39NbaOS7++ea7tK40XDeWGYE/btYtN3FUHUyFJhROS6McnO+O7iH
         QPGQ9mQJaLkuZ0t+SDPhDXXZiqschiwi3FYXIrbmho3OznwaItHZg/pZ3huJV1XUEw2E
         cNZg==
X-Gm-Message-State: AO0yUKVcRLfagCXiESx1ekRe1BGOMAmS1V8plQ4Q+7UhFkhBJCiGBlpF
        bpcMo7p2/oHWW1V3knX6Q60=
X-Google-Smtp-Source: AK7set/wQ+37CgFbge5PWcKRfAPog2dI1ab9mJdFRTdZzk13Uw1WQ8F4y3kqvHrOHGQ3ixy37HIFhw==
X-Received: by 2002:adf:e189:0:b0:2bf:ae19:d8dd with SMTP id az9-20020adfe189000000b002bfae19d8ddmr6897863wrb.37.1674659159649;
        Wed, 25 Jan 2023 07:05:59 -0800 (PST)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d6842000000b002be5401ef5fsm4704041wrw.39.2023.01.25.07.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 07:05:59 -0800 (PST)
Message-ID: <879c35aa-35a3-b6dd-21f0-5355bcedbb55@gmail.com>
Date:   Wed, 25 Jan 2023 16:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v30 00/11] Add MediaTek SoC(vdosys1) support for mt8195
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        CK Hu <ck.hu@mediatek.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, llvm@lists.linux.dev,
        singo.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230113104434.28023-1-nancy.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230113104434.28023-1-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whole series applied, thanks!

On 13/01/2023 11:44, Nancy.Lin wrote:
> The hardware path of vdosys1 with DPTx output need to go through by several modules, such as, OVL_ADAPTOR and MERGE.
> 
> Add mmsys and mutex modules support by the patches below:
> 
> Changes in v30:
> - rebase to next-20230113
> - fix reviewer comment in v29
>    - fix mmysy binding doc for vdosys1
> 
> Changes in v29:
> - rebase to next-20221226
> - fix reviewer comment in v28
>    - fix mmsys binding doc for vdosys1
> 
> Changes in v28:
> - rebase to next-20221107
> - fix reviewer comment in v27
>    - remove change id
>    - fix mmsys config api typo
> 
> Changes in v27:
> - rebase to next-20221102
> - change mmsys compatible for mt8195 vdosys1
>    - base on jason's series[ref 1]
> - fix reviewer comment
>    - only register mmsys reset controller if num_resets > 0
> 
> Changes in v26:
> - fix reviewer comment
>    - set mmsys num_resets to 32 for 8192
> - rebase to next-20220819
> 
> Changes in v25:
> - fix reviewer comment
>    - refine mtk_mmsys_reset_update func
> - rebase to next-20220708
> 
> Changes in v24:
> - fix reviewer comment
>    - refine mtk_mmsys_reset_update func
> - rebase to next-20220622
> 
> Changes in v23:
> - separate[7] mmsys/mutex and drm patches into two series
> 
> Changes in v22:
> - rebase to next-20220525
> - rebase to vdosys0 series v22
> - separate dts to a new patch
> 
> Changes in v21:
> - fix reviewer comment
>    - fix rdma and ethdr binding doc and dts
> 
> Changes in v20:
> - fix reviewer comment
>    - update mmsys update bit api name
>    - add mtk_mmsys_update_bits error message if lose gce property
>    - list all mt8195 vdosys1 reset bits
> 
> Changes in v19:
> - fix reviewer comment
>    - separate mt8195 mmsys component to a new patch
>    - separate mt8195 vdo0 and vdo1 routing table
>    - separate mmsys_write_reg api to a new patch and simplify write reg code
>    - separate mmsys 64 bit reset to a new patch
>    - separate mtk-mutex dp_intf1 component to a new patch
> 
> Changes in v18:
> - fix reviewer comment
>    - fix rdma binding doc
>    - fix ethdr binding doc
>    - refine mmsys config cmdq support
>    - refine merge reset control flow, get reset control in probe function
>    - add ethdr reset control error handling and remove dbg log
> - rebase to vdosys0 series v20 (ref [5])
> 
> Changes in v17:
> - fix reviewer comment in v16
>    - separate ovl adaptor comp in mtk-mmsys and mtk-mutex
>    - separate mmsys config API
>    - move mdp_rdma binding yaml
> - fix ovl adaptor pm runtime get sync timing issue
> - rebase to vdosys0 series v19 (ref [5])
> - rebase to [7] for modify vblank register change
> 
> Changes in v16:
> - fix reviewer comment in v 15
>    - fix mtk_drm_ddp_comp.c alignment
>    - fix vdosys0 mmsys num before adding vdosys1 patch
> 
> Changes in v15:
> - fix ethdr uppercase hex number in dts
> 
> Changes in v14:
> - remove MTK_MMSYS 64 bit dependency
> - add ethdr.yaml back and fix dt_schema check fail
> 
> Resend v13
> - add related maintainer in maillist
> 
> Changes in v13:
> - fix reviewer comment in v12
>    - fix rdma dt-binding format
>    - fix dts node naming
> - fix 32 bit build error
>    - modify 64bit dependency for mtk-mmsys
> - rebase to vdosys0 series v16. (ref [5])
> 
> Changes in v12:
> - fix reviewer comment in v11
>    - modify mbox index
>    - refine dma dev for ovl_adaptor sub driver
> 
> Changes in v11:
> - remove ethdr vblank spin lock
> - refine ovl_adaptor print message
> 
> Changes in v10:
> - refine ethdr reset control using devm_reset_control_array_get_optional_exclusive
> - fix ovl_adaptor mtk_ovl_adaptor_clk_enable error handle issue
> 
> Changes in v9:
> - rebase on kernel-5.16-rc1
> - rebase on vdosys0 series v13. (ref [5])
> - fix ovl_adaptor sub driver is brought up unintentionally
> - fix clang build test fail- duplicate ethdr/mdp_rdma init_module/cleanup_module symbol issue
> 
> Changes in v8:
> - separate merge async reset to new patch.
> - separate drm ovl_adaptor sub driver to new patch.
> - fix reviewer comment in v7.
> 
> Changes in v7:
> - rebase on vdosys0 series v12 (ref[5])
> - add dma description in ethdr binding document.
> - refine vdosys1 bit definition of mmsys routing table.
> - separate merge modification into 3 pathces.
> - separate mutex modification into 2 patches.
> - add plane color coding for mdp_rdma csc.
> - move mdp_rdma pm control to ovl_adaptor.
> - fix reviewer comment in v6.
> 
> Changes in v6:
> - rebase on kernel-5.15-rc1.
> - change mbox label to gce0 for dts node of vdosys1.
> - modify mmsys reset num for mt8195.
> - rebase on vdosys0 series v10. (ref [5])
> - use drm to bring up ovl_adaptor driver.
> - move drm iommu/mutex check from kms init to drm bind.
> - modify rdma binding doc location. (Documentation/devicetree/bindings/arm/)
> - modify for reviewer's comment in v5.
> 
> Changes in v5:
> - add mmsys reset controller reference.
> 
> Changes in v4:
> - use merge common driver for merge1~4.
> - refine ovl_adaptor rdma driver.
> - use ovl_adaptor ddp_comp function instead of ethdr.
> - modify for reviewer's comment in v3.
> 
> Changes in v3:
> - modify for reviewer's comment in v2.
> - add vdosys1 2 pixels align limit.
> - add mixer odd offset support.
> 
> Changes in v2:
> - Merge PSEUDO_OVL and ETHDR into one DRM component.
> - Add mmsys config API for vdosys1 hardware setting.
> - Add mmsys reset control using linux reset framework.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> 
> This series are based on the following patch:
> [1] Change mmsys compatible for mt8195 mediatek-drm
>      20221126101220.18179-1-jason-jh.lin@mediatek.com
> 
> Nancy.Lin (11):
>    dt-bindings: arm: mediatek: mmsys: add vdosys1 compatible for MT8195
>    dt-bindings: reset: mt8195: add vdosys1 reset control bit
>    soc: mediatek: add mtk-mmsys ethdr and mdp_rdma components
>    soc: mediatek: add mtk-mmsys support for mt8195 vdosys1
>    soc: mediatek: refine code to use mtk_mmsys_update_bits API
>    soc: mediatek: add mtk-mmsys config API for mt8195 vdosys1
>    soc: mediatek: add cmdq support of mtk-mmsys config API for mt8195
>      vdosys1
>    soc: mediatek: mmsys: add mmsys for support 64 reset bits
>    soc: mediatek: mmsys: add reset control for MT8195 vdosys1
>    soc: mediatek: add mtk-mutex component - dp_intf1
>    soc: mediatek: add mtk-mutex support for mt8195 vdosys1
> 
>   .../bindings/arm/mediatek/mediatek,mmsys.yaml |   1 +
>   drivers/soc/mediatek/mt8195-mmsys.h           | 146 +++++++++++++++++
>   drivers/soc/mediatek/mtk-mmsys.c              | 149 +++++++++++++-----
>   drivers/soc/mediatek/mtk-mmsys.h              |   1 +
>   drivers/soc/mediatek/mtk-mutex.c              |  37 +++++
>   include/dt-bindings/reset/mt8195-resets.h     |  45 ++++++
>   include/linux/soc/mediatek/mtk-mmsys.h        |  25 +++
>   7 files changed, 366 insertions(+), 38 deletions(-)
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3615BC3D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiISH65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiISH6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:58:16 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367171EEF8;
        Mon, 19 Sep 2022 00:58:15 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id l14so12858596qvq.8;
        Mon, 19 Sep 2022 00:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KKxwW22QapRcZpKvTVaesc2qXSXnP+OfFDAXgdUxUEQ=;
        b=Q+jR8uW5jtw7QssRCfQjrVvgHZc9j7f75pvbmUSspp0aqU4bpNQ4eq6Y8SxicoIAhV
         Jp+9sX19PPId0PaNQvYfW66HK97w2po7E5xdRiBTmS51kCDppXo72qqbI30DMlDvrPBz
         zx5g4Z/zQ3CU4rPCWHrnvgE/QqKLY/64kA8EsiDtPPG6p5hymdM/9P68v3okzncoKYoI
         +F1+Gsr7e68c3nHqpuCPBnkj4ANU4yokGlkN21o4+eSKduWVIH58HVwPIpZwktG4/stE
         hTIPT8t/s8GqGY0V9dQTiyyLYfEgDQ/vLqYSJa8furmNIW/k+j7j/fdgb2S4PBqnHBBi
         eH/g==
X-Gm-Message-State: ACrzQf0/HZDCqU82UdDDeiErPC7fay+EO0dqO/gTGMrmFxW2Fls9E/4D
        yl3R5KlRcYx8AM2T7kI1ny1OFMsZvcSQBQ==
X-Google-Smtp-Source: AMsMyM6Dm/E7NPv4Ku1nXM/6vdKuP3hxC5P+9txaY2TG7AVa+dB1ETFEkqE2PXhGgq9bWNV7K3jGfQ==
X-Received: by 2002:a05:6214:2a89:b0:4ac:8360:6c65 with SMTP id jr9-20020a0562142a8900b004ac83606c65mr13159334qvb.110.1663574293776;
        Mon, 19 Sep 2022 00:58:13 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id u18-20020a05622a011200b0035ba4e53500sm10409139qtw.56.2022.09.19.00.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 00:58:13 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 130so41330301ybw.8;
        Mon, 19 Sep 2022 00:58:13 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr12533972ybl.604.1663574293041; Mon, 19
 Sep 2022 00:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220919105839.496f1b72@canb.auug.org.au>
In-Reply-To: <20220919105839.496f1b72@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Sep 2022 09:58:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVQmG6hjyw0g8L2AAuUSoQ9xH=C9zrV=QUoVWp_HM62BQ@mail.gmail.com>
Message-ID: <CAMuHMdVQmG6hjyw0g8L2AAuUSoQ9xH=C9zrV=QUoVWp_HM62BQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Sep 19, 2022 at 3:07 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Today's linux-next merge of the drm tree got a conflict in:
>
>   drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
>
> between commit:
>
>   41012d715d5d ("drm/amd/display: Mark dml30's UseMinimumDCFCLK() as noinline for stack usage")
>
> from Linus' tree and commit:
>
>   a0f7e7f759cf ("drm/amd/display: fix i386 frame size warning")
>
> from the drm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> index 1cb858dd6ea0,b7fa003ffe06..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> @@@ -6610,66 -6497,11 +6497,11 @@@ static double CalculateUrgentLatency
>         return ret;
>   }
>
>  -static void UseMinimumDCFCLK(
>  +static noinline_for_stack void UseMinimumDCFCLK(

While this looks like the correct merge resolution, it does mean that
both stack size mitigations are now applied, and probably one of them
can be dropped?

>                 struct display_mode_lib *mode_lib,
> -               int MaxInterDCNTileRepeaters,
> +               struct vba_vars_st *v,
>                 int MaxPrefetchMode,
> -               double FinalDRAMClockChangeLatency,
> -               double SREnterPlusExitTime,
> -               int ReturnBusWidth,
> -               int RoundTripPingLatencyCycles,
> -               int ReorderingBytes,
> -               int PixelChunkSizeInKByte,
> -               int MetaChunkSize,
> -               bool GPUVMEnable,
> -               int GPUVMMaxPageTableLevels,
> -               bool HostVMEnable,
> -               int NumberOfActivePlanes,
> -               double HostVMMinPageSize,
> -               int HostVMMaxNonCachedPageTableLevels,
> -               bool DynamicMetadataVMEnabled,
> -               enum immediate_flip_requirement ImmediateFlipRequirement,
> -               bool ProgressiveToInterlaceUnitInOPP,
> -               double MaxAveragePercentOfIdealSDPPortBWDisplayCanUseInNormalSystemOperation,
> -               double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
> -               double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
> -               double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelDataOnly,
> -               int VTotal[],
> -               int VActive[],
> -               int DynamicMetadataTransmittedBytes[],
> -               int DynamicMetadataLinesBeforeActiveRequired[],
> -               bool Interlace[],
> -               double RequiredDPPCLK[][2][DC__NUM_DPP__MAX],
> -               double RequiredDISPCLK[][2],
> -               double UrgLatency[],
> -               unsigned int NoOfDPP[][2][DC__NUM_DPP__MAX],
> -               double ProjectedDCFCLKDeepSleep[][2],
> -               double MaximumVStartup[][2][DC__NUM_DPP__MAX],
> -               double TotalVActivePixelBandwidth[][2],
> -               double TotalVActiveCursorBandwidth[][2],
> -               double TotalMetaRowBandwidth[][2],
> -               double TotalDPTERowBandwidth[][2],
> -               unsigned int TotalNumberOfActiveDPP[][2],
> -               unsigned int TotalNumberOfDCCActiveDPP[][2],
> -               int dpte_group_bytes[],
> -               double PrefetchLinesY[][2][DC__NUM_DPP__MAX],
> -               double PrefetchLinesC[][2][DC__NUM_DPP__MAX],
> -               unsigned int swath_width_luma_ub_all_states[][2][DC__NUM_DPP__MAX],
> -               unsigned int swath_width_chroma_ub_all_states[][2][DC__NUM_DPP__MAX],
> -               int BytePerPixelY[],
> -               int BytePerPixelC[],
> -               int HTotal[],
> -               double PixelClock[],
> -               double PDEAndMetaPTEBytesPerFrame[][2][DC__NUM_DPP__MAX],
> -               double DPTEBytesPerRow[][2][DC__NUM_DPP__MAX],
> -               double MetaRowBytes[][2][DC__NUM_DPP__MAX],
> -               bool DynamicMetadataEnable[],
> -               double VActivePixelBandwidth[][2][DC__NUM_DPP__MAX],
> -               double VActiveCursorBandwidth[][2][DC__NUM_DPP__MAX],
> -               double ReadBandwidthLuma[],
> -               double ReadBandwidthChroma[],
> -               double DCFCLKPerState[],
> -               double DCFCLKState[][2])
> +               int ReorderingBytes)
>   {
>         double   NormalEfficiency = 0;
>         double   PTEEfficiency = 0;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166D2631525
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 17:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiKTQWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 11:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTQWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 11:22:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0812BB38;
        Sun, 20 Nov 2022 08:22:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE846B80AB5;
        Sun, 20 Nov 2022 16:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBD4C433D6;
        Sun, 20 Nov 2022 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668961331;
        bh=AvGWndf9DEUET9v4kdItBXdmJAoBuDgCn9w6FkJssmk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HioxJyPvhlImnnR5X+IKH7hmlE8puQWZhMtTi7QMvmm3du6JRG1iGv+XQvnDeltSi
         BDE+t4hIPEXB/IL+GaVRpFAJRpBvnFTLUOJEBphYw1AQ/UWOygdUDWSO5YeRZTAXLB
         AjL0Zxc6DY/TvAMHHKLT19kN9rX3LHYyvNwanvHAMFSdMo4mgxZubHb/Vw/QeA3h2r
         Zopr4pRwViA30f1g+vhPy0XRGK+LZfEWzx0DG1d9bnh2LlPpCQsJ8MMKnQgIppFjpc
         zMm6e6b/j+xFmUPgfxpM86K3tT0wLUpfdYdys6m63P33L0+8ao92lmUDYM0gppxdco
         OppzxreGwQTNA==
Received: by mail-vs1-f45.google.com with SMTP id i2so9146768vsc.1;
        Sun, 20 Nov 2022 08:22:11 -0800 (PST)
X-Gm-Message-State: ANoB5plEHFW4GWsmJOm0uN4CwdziwaSH+k6gQcu/Qag+V90NwHfapu2t
        E/WKwGE/bdziCqlQ7/TLoNSeoNT9NQlni1mQSw==
X-Google-Smtp-Source: AA0mqf7SBhcBASLFxcQXAoOn9Y1jTXtcGZU8frmuVaZShM2yIv9ViwOjexiPe4OFPzD1xZNIBQuMOLLrdLRrIy0d7WM=
X-Received: by 2002:a67:fa14:0:b0:3b0:521e:dd08 with SMTP id
 i20-20020a67fa14000000b003b0521edd08mr306963vsq.0.1668961330462; Sun, 20 Nov
 2022 08:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20221114233940.2096237-1-tanmay.shah@amd.com> <20221116183814.GD61935@p14s>
In-Reply-To: <20221116183814.GD61935@p14s>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 20 Nov 2022 10:22:01 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ECUjFJHED9UnsgDrZQY_LUavDcQesZCwsnSH=iQCyrA@mail.gmail.com>
Message-ID: <CAL_Jsq+ECUjFJHED9UnsgDrZQY_LUavDcQesZCwsnSH=iQCyrA@mail.gmail.com>
Subject: Re: [PATCH v11 0/6] Add Xilinx RPU subsystem support
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@amd.com,
        bill.mills@linaro.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:38 PM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Hi Tanmay,
>
> I think this patchset is ready to be merged.  Two things are missing though:
>
> Patches 1 and 2: We are missing a tag from one of the fellow in the DT brigade.
> They handle a lot of patches so let's give them time.

Patch 2 should go via the sub-arch tree. I don;t review .dts files regularly.

Rob

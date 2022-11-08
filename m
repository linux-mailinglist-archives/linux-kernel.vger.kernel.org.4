Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446A462061C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiKHBdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiKHBcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:32:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D972B250;
        Mon,  7 Nov 2022 17:30:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1589B81714;
        Tue,  8 Nov 2022 01:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58C1C433C1;
        Tue,  8 Nov 2022 01:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667871051;
        bh=0yBZHoDeAsx88XhELODMBIElqdEk3adTf9nXLZge1ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0B2Iu5Ms8CoTSUOD8gb4w79uATuWiyzX1YnEckxthgG+aPpcnkynxjHluphhgyPH
         2n3N8q4g8FDNTPG38kq0Il/EKoT+ibgPfjcKsk9w4dU3jqSXDIECsSBB7KA91/q/aN
         57keLiFlkjEl3xxhX2cfZG6WhC/LEg+arKMHYfac4mLojETvXDHvdfaiO0CBB1T5Ve
         Pbzzahaqt367SPfupSM16BF+7UvY4G1HWogU9JRcbSQWWbnr7YEzNGaSHdJu4/D+85
         Bd4F8YJRjDLoNqOL/SS/+H6QmdusCnj0S3Rz5ft8lAC7I/IlN38eRVj3fMr2UH/XKs
         EY35Bm/08Gtuw==
Date:   Mon, 7 Nov 2022 19:30:48 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Gross <agross@kernel.org>,
        Matti =?utf-8?Q?Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Rayyan Ansari <rayyan@ansari.sh>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the qcom tree
Message-ID: <20221108013048.7uu4gseeysbzpoqt@builder.lan>
References: <20221108090018.44624610@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108090018.44624610@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 09:00:18AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the qcom tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> arch/arm/boot/dts/qcom-msm8226.dtsi:302.21-327.5: ERROR (phandle_references): /soc/cci@fda0c000: Reference to non-existent node or label "mmcc"
> 

Sorry about that, not sure why I didn't catch that before pushing my
branch. I've pulled in the missing patch today.

Thanks,
Bjorn

> Caused by commit
> 
>   4ab2f41b0850 ("ARM: dts: qcom: msm8226: Add CCI bus")
> 
> I have used the qcom tree from next-20221107 for today.
> 
> -- 
> Cheers,
> Stephen Rothwell



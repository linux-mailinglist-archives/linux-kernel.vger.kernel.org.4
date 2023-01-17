Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BE566D667
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 07:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbjAQGmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 01:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjAQGmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 01:42:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A9C1DB8E;
        Mon, 16 Jan 2023 22:42:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6146611C0;
        Tue, 17 Jan 2023 06:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E68C433D2;
        Tue, 17 Jan 2023 06:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673937757;
        bh=yzPP1cFlzSh+Kd/LjYuGaEr0HJCT+IzujClRJbeEUaM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Jss2Pyn9eMrzihH6JtMtc/G592WrcDR1Xv29P0Ty2NF0m/3I9A0/SA0D8xBrbEg33
         RofaH84/Z18wVoKcpknXiiGKoZv7i1T4aoW4s4HPL9xmulSYXqB8cN3ePTs/lduWRz
         53owCw418EanPtY17c1kc5bRbdAmIyM9ntjwf26WRK3nCc45cgbMoDJ1WJJAFn6OZL
         zAawNfRYSZD4/GceW5KObifpK0vw/bI8kpMO33s/V38hlpMrCmyzYY2sFXHMQZl4u9
         8gy8co85KcbSQOpiRTKc7f36kIuNMl1kO2MXcmv6vN3OffNvEePkjIgAFXQLjCEGJu
         thy3eOyPDvVOg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Mike Lothian <mike@fireburn.co.uk>, nbd@nbd.name,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org, lorenzo@kernel.org,
        sujuan.chen@mediatek.com
Subject: Re: [6.2][regression] after commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae stopping working wifi mt7921e
References: <CAHbf0-EHP0cRDhOD_3Mf4aRzndoVYGbd3j3vxwUOh9_cHp+h1Q@mail.gmail.com>
        <CABXGCsMz6qs0qSMoF6F3B_kJt+UwULtfpp2pCNxUuWAqAryniA@mail.gmail.com>
Date:   Tue, 17 Jan 2023 08:42:31 +0200
In-Reply-To: <CABXGCsMz6qs0qSMoF6F3B_kJt+UwULtfpp2pCNxUuWAqAryniA@mail.gmail.com>
        (Mikhail Gavrilov's message of "Tue, 17 Jan 2023 10:42:55 +0500")
Message-ID: <87r0vt8xwo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> writes:

> On Tue, Jan 17, 2023 at 5:33 AM Mike Lothian <mike@fireburn.co.uk> wrote:
>>
>> Hi
>>
>> I'm struggling to find these patches on Patchwork, or apply the saved
>> raw patches to rc4
>>
>> If I'm missing them, would you mind posting the link
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20230113105848.34642-3-nbd@nbd.name/

And the patches are now applied to the wireless tree:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

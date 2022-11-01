Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF64C6146A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiKAJ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKAJ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:29:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D5B2648;
        Tue,  1 Nov 2022 02:29:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7788061552;
        Tue,  1 Nov 2022 09:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA662C433C1;
        Tue,  1 Nov 2022 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667294952;
        bh=SHCUtKcvJiP4x/pfLfKcS8SGR09keelP++DTClcWsqc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cRvh8ggN/RxQBCdsU51vlzlPibZ2lM/sx/5X9NrqF6NFfBJ+E/swRKcWlgI7iu0vK
         ZhBcOL4zN08RK0na63PPvV+TAtDp8j9ebRUVLG01B7d+fquzBTVI2fhBj27DXg9bBF
         1Tnf7LUy3hRUZr2xxzvltB+BnRGzDUvCjcF1xmM47T0cOI/gHrYElWwH8ZGj/lQoIg
         ShnUJa781rfoUwSmktyxaeeSA0Zg5J/lKEFynW3kcZV7shKBlxEcdG3aYDxpd0fENx
         aX5bXTqM0VCOQYZtC8+pdJ9DlIVT5SJ04pPosXr2fJhxYpbOUxSm+icKZC7GivlYNG
         vHPVartbWfqcQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Youghandhar Chintala \(Temp\)" <quic_youghand@quicinc.com>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath10k: Add WLAN firmware image version info into smem
References: <20221026102257.19919-1-quic_youghand@quicinc.com>
        <b55ef95f-f400-9ef6-a427-525ae529d673@quicinc.com>
        <fd45187c-739c-cd5d-4d4b-ae6abad03a94@quicinc.com>
        <877d0fgiaa.fsf@kernel.org>
        <722d3571-b399-dbf0-26da-04b73331df49@quicinc.com>
Date:   Tue, 01 Nov 2022 11:29:09 +0200
In-Reply-To: <722d3571-b399-dbf0-26da-04b73331df49@quicinc.com> (Youghandhar
        Chintala's message of "Tue, 1 Nov 2022 14:38:22 +0530")
Message-ID: <8735b3gh0a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com> writes:

> On 11/1/2022 2:31 PM, Kalle Valo wrote:
>
>> BTW Youghandhar, your quotes were broken in this mail so your reply was
>> difficult to find. See here:
>>
>> https://patchwork.kernel.org/project/linux-wireless/patch/20221026102257=
.19919-1-quic_youghand@quicinc.com/
>>
>> If you are using Outlook, I recommend switching to an application which
>> respects standards more :) For example, some people seem to be happy
>> with Thunderbird.
>
>
> Thank you so much for your suggestion. I will address it.
>
> Currently I am using=C2=A0 Thunderbird.

Good, and now your quotes were correct.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

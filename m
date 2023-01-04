Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB27965CED5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjADIyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbjADIym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:54:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEF718E3F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:54:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14D80615E9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EE6C433EF;
        Wed,  4 Jan 2023 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672822470;
        bh=NSTw/vhp+SBtVWvTIpyri3iq9dAh1xUqGLzn3UaRiSg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lEbmH/KdTiqyjLf2n2kxJGdwbFL4US2npc+yqQqjlUWRd4Xq/L+KkonnPG4dQOg3L
         0ofiTjZrhPTcTpjrYS5g5alLwYyBn8hq26ZT7n9IDctvnpEI1wFiisB92cgdQ8odlN
         A4N4NKMIkSYBgyPyFyquzyxcboo50Gp+eYI5b/2vSQk9ZeyquISURPl0bs+4WG72uj
         pwsgsSPUbKU9dN4wauWuFys484gvjvVzgsc5Cd8rkvaZ3w2NAHZanfypFVjFUyn7Q5
         mAjvvsNhxe7xc1C1jQrmaZqSO45CuGxJgxybAkSmAvkXxT9RRNczr/hnBtKbMwfL0+
         3fOgXh4k216hg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     "liaochang (A)" <liaochang1@huawei.com>,
        Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] riscv/kprobe: Prepare the skeleton to prepare
 optimized kprobe
In-Reply-To: <9dacbd7a-6dc5-099c-d427-b20bfa22aabd@huawei.com>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-4-chenguokai17@mails.ucas.ac.cn>
 <87v8lovmoa.fsf@all.your.base.are.belong.to.us>
 <9dacbd7a-6dc5-099c-d427-b20bfa22aabd@huawei.com>
Date:   Wed, 04 Jan 2023 09:54:28 +0100
Message-ID: <875ydmsmrf.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"liaochang (A)" <liaochang1@huawei.com> writes:

>>> +	 */
>>> +	rel =3D (unsigned long)slot - (unsigned long)orig->addr;
>>> +	if (!in_auipc_jalr_range(rel)) {
>>> +		/*
>>> +		 * Different from x86, we free code buf directly instead
>>> of
>>=20
>> Reword for readers that are not familiar with x86.
>
> OK, BTW, i think the code following tag on_error is fairly self-explanato=
ty,
> perhaps this comment is no need anymore.

Fair enough! :-)


Bj=C3=B6rn

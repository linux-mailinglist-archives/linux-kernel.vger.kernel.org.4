Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0AC66D124
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjAPV5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjAPV5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:57:20 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773B124492
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 13:57:18 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 609505C01C5;
        Mon, 16 Jan 2023 16:57:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 16 Jan 2023 16:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=cc:cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1673906235; x=1673992635; bh=pB7OzMUP2R+eFx2+0Tb9eBFUfZ26JGznjxb
        wj0Je6iY=; b=K35m0ZDUtc1iU8uC+gueRpCQA3uBExWFyRcS984nW4EEtJuYe/6
        7a+z4MtSoMnOMsLUD6z4+N4WLBWOT8ieE+c3ryAecmH+i78EoyLpnVvMPTsNGaeE
        YRMWApj8F225J9Jj/NENmc8GVvMfipCZrx6SlZmCy1q9Z8Vm33Bwi+Z7BRWCHTaz
        PeCWD+f/1zgBXHg04sjloOF+NOGksZ3t+ZcMiqAsdnQUny0PSNlkjNPEhwxhExSK
        IIjybp8eINNOkwpyTsikp92TvT+Vv/QtbdVpUd3BQDUvCGfNH9G6isV600+5H2Jg
        fZDZ6S4Su32dYeQ6lT3T7IUDo4qRcmxnNSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1673906235; x=
        1673992635; bh=pB7OzMUP2R+eFx2+0Tb9eBFUfZ26JGznjxbwj0Je6iY=; b=C
        y5pw0QGd6gFDnxTcWPFFr2oseOmzv+OErsNmA0ftXgnlEEakrpFN7EQl8aPzO5kS
        pmmaYCsateilTsaUIDJq49YtPHa6g8jgt/3ZkT2PzDRCS3Vc7LI+g/2ha9oxHhCr
        6rWdXfhmikza83x9v7PVrBUghGKokur0AlP2byOIpBk7Wi1bH1A8XGYAlKDmb+vr
        CMrMKsCCGN4NNWmjkUoYGCLMWFWypZR1VOya+t4mCu8LG3CBYIAqoBMDQNGZN1ik
        Uv8rHyK8mWYCub1x/wkAxzFDsd+LGkpK5FCGdSHxoYGZpo4DjLpzdWTdTD+PEpS/
        IQ9n3wjNplEFR2mvNCVVg==
X-ME-Sender: <xms:O8jFY46iJbgYI921Z-tJLlZJqCEQZy5J6-d6IermOT1DGqGIyP8cDQ>
    <xme:O8jFY57m737goO0CwdwQ_sv6rJUXJ8KGyC1GaIwl63E6a6vHn7uibCalniMNH0VjU
    wYfmLcHdysWR-oh4I4>
X-ME-Received: <xmr:O8jFY3d9Xyo5fjWa-9a5keT9DNOTWj7YQdpiXsVoZbRtfSJAR7VSP4xExLHEmlPZnzMKW6LlTKS9s8w2a5wkPWzKvmc2IA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfggtggusehgtderredttdejnecuhfhrohhmpefmlhgruhhs
    ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
    gvrhhnpedtjefgteejuedvkeefjefgieekueetvdduheffkeehjeevleehhedvgfeiudeh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
    hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:O8jFY9LB-PWWMz1Ccm6Uu8yTZHr01hS22F8bGPNdL1IKX73e5B_wTw>
    <xmx:O8jFY8L26D5rtqfEaIzUyy0ivp-RTzvuqQVehm7hTi02xMwiLDtG4Q>
    <xmx:O8jFY-z4oU76ojKZANQEs3VsDy63lCw4C2IYcV9xAlvRxz5w9vaAag>
    <xmx:O8jFY2gqn4GXS1Ic4IAefZX8WnPfroZNrwGJggc0HYcvwlFtN4i6Hw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jan 2023 16:57:13 -0500 (EST)
Date:   Mon, 16 Jan 2023 22:57:11 +0100
From:   Klaus Jensen <its@irrelevant.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: regression on aarch64? panic on boot
Message-ID: <Y8XINx8fpGPKudW6@cormorant.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Wv4oHFnziRYt8pYX"
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wv4oHFnziRYt8pYX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I'm getting panics when booting from a QEMU hw/nvme device on an aarch64
guest in roughly 20% of boots on v6.2-rc4. Example panic below.

I've bisected it to commit eac3ef262941 ("nvme-pci: split the initial
probe from the rest path").

I'm not seeing this on any other emulated platforms that I'm currently
testing (x86_64, riscv32/64, mips32/64 and sparc64).


nvme nvme0: 1/0/0 default/read/poll queues
NET: Registered PF_VSOCK protocol family
registered taskstats version 1
nvme nvme0: Ignoring bogus Namespace Identifiers
/dev/root: Can't open blockdev
VFS: Cannot open root device "nvme0n1" or unknown-block(0,0): error -6
Please append a correct "root=" boot option; here are the available partitions:
103:00000      61440 nvme0n1
 (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc4 #22
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace.part.0+0xdc/0xf0
 show_stack+0x18/0x30
 dump_stack_lvl+0x7c/0xa0
 dump_stack+0x18/0x34
 panic+0x17c/0x328
 mount_block_root+0x184/0x234
 mount_root+0x178/0x198
 prepare_namespace+0x124/0x164
 kernel_init_freeable+0x2a0/0x2c8
 kernel_init+0x2c/0x130
 ret_from_fork+0x10/0x20
Kernel Offset: disabled
CPU features: 0x00000,01800100,0000420b
Memory Limit: none
---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0) ]---

--Wv4oHFnziRYt8pYX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmPFyDcACgkQTeGvMW1P
DekuvwgAnzpWdriYkhJke67vy04eHNX22UnTthB8dHmz1+lqaGyqak1ih8SFrzr6
t/v9UNJA/JJ/k6smupIOd0UA2DtbeoCEEOgnjXGoUBerRbzbJNyquc/2HtRKzprt
lAHHUQ5Le/d93yK9jskzkyLmZQAYUClK1JKcADg+5Kz/+K/OnrxarYJ8qMOI0pLb
I0TUBKTCEWVGOsprzfNFCJ2ug3Yjf/64wjYSohAZm9+5U+Svyl4rWTF3iHeC6eaX
whyES8dOA7bHGGr/2gWpqU0WPbPVEdrQc4yKfShDJ2PBqfn4vEGEalFjYHqqzIEE
LZsqcIfH2N5fkqRVfU5Hf+pwAQxiPg==
=ifcL
-----END PGP SIGNATURE-----

--Wv4oHFnziRYt8pYX--

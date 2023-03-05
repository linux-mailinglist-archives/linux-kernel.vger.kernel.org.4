Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D2A6AB21C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 21:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCEUkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 15:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCEUkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 15:40:08 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB03611EA6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 12:40:06 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 46AC75C0046;
        Sun,  5 Mar 2023 15:40:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 05 Mar 2023 15:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1678048805; x=
        1678135205; bh=wC95Fc8WLi0uoy3J/mMJTNPyh7Buzl1RCLVdf0LxT/8=; b=D
        tJfEicQN85wYIe4pDF0QhlBpKUWIrjnnU1Odjx/jcH0q2aXlfmP/o1Me7ukqjIR0
        O4x+N3YkKOaW0IUPS5VJsD3Xx9M2eOHE222nyuXAuLu0ElVj93Cnq8j7Cs0NEBxV
        ETQqCOBVnyoGfsfyibdaGRbHy/KqpZRuqLtJ8fX+RiQtgpyXo9a9io+hHJDmp3YE
        xpzlZOB5gBhk71W18mIQ7is/4caaYIfGFjGtI4zGD7/swo+d+dgUNYgrfUP7T6wv
        PmthfBMj/oFnTJq4p9g10+i5Ju3aJBnM57F0ZO7gCZnRTOmIN0y9O7iudB5rNcsQ
        fmmZsnslf6QRqekuM2s1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1678048805; x=1678135205; bh=wC95Fc8WLi0uoy3J/mMJTNPyh7Bu
        zl1RCLVdf0LxT/8=; b=JAScaSZf6HoDj1K54NYs0XsJXBis+6iCdT9z9PN7RDWs
        m6iC8hxpWCY7hv5RR/0hkSufyha98z++NuUdgXS2hfIFpH7QtGif3myg9YKhqttC
        vFiWzoU9985MN0Gyk3LlvADij1mZwmahhR2pF/aX3AWvxkKBd8PcCHS5TNi7kBEh
        rPbtPykImPbT+pUTZWgcLqpq3Qz8oFROO2lGPEz2dBcWV4mP9Q/xkMu2+3fhrb5C
        m0feXXJsRNXtshY1GyN5Q85pE73TF+nVz7wCBvr7/fKMt2efuNxSjTT/bO3aWNlf
        JLbsJ6KzM29GJgB0wdk4XMjUhWjE4x5b+Vg9DAvsSw==
X-ME-Sender: <xms:JP4EZFiQsQAjKE10Ly2MBHPOOWmMrX2Zm9nN7o61l3mxLYgNVb_V1w>
    <xme:JP4EZKChX3yWqjOmBnxWSvLxDYyuN6zPhfy15wQ3edBuvumFBat5PvBf_Amwvt_yK
    OHgZaxyltoQyDU>
X-ME-Received: <xmr:JP4EZFHpzZaLWxOUC-hCHrdwIuaLmgUifKE0YJEFBIl51cOH8QTqduX19Bs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtgedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhrgggtsehttdertddttddvnecuhfhrohhmpeffvghmihcu
    ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefhleetjeefvdegieevjedtteduieel
    feeileejleeuhfehleegudduleefuefhjeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhl
    rggsrdgtohhm
X-ME-Proxy: <xmx:Jf4EZKSJ2s44HSDlymYwMGNUhbJmAIIg-Kh6KDd8CagRdcAMysanzA>
    <xmx:Jf4EZCy3KcK_ZnWy4WfwfDFLqDj-PBo_ZIpPTaPdTv4hcPyl0g92Eg>
    <xmx:Jf4EZA4iy6v6FAfR9GoTly-CeqQyZmn-QUlO5TLdM3Eet1cp_tzbbw>
    <xmx:Jf4EZG97BNOSUajl13mpdo9IkYw1Vodv9ZZNpP6Iz31tfvM7QP1nVA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Mar 2023 15:40:04 -0500 (EST)
Date:   Sun, 5 Mar 2023 15:40:02 -0500
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Joe Thornber <thornber@redhat.com>
Cc:     "development, device-mapper" <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Qubes OS Development Mailing List 
        <qubes-devel@googlegroups.com>, dm-devel@lists.ewheeler.net
Subject: Thin pool CoW latency
Message-ID: <ZAT+IoCfuZtRnnhm@itl-email>
Reply-To: CAJ0trDYAyHHh2crMAQuQPMt3FzFmii0nmLnsL5N-cdhfvWZnMg@mail.gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Like Eric, I am very concerned about CoW latency and throughput.  I
am almost certain that allocating new blocks and snapshot copy-on-write
are _the_ hot paths in Qubes OS.  In particular, I suspect that
workloads such as building an image in a throwaway VM or installing
packages onto a root volume that had just been shapshotted are dominated
by metadata operations, rather than by in-place updates.  I suspect that
frequently-snapshotted volumes will observe similar behavior in general.
- -- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmQE/iEACgkQsoi1X/+c
IsHLFxAAyWT4SlSueR15VxrwG07T9cEl7vnQwKHKWdzFBoWl0KhvyjLr52t0ip1J
HPmwTVaor+53E+0bLUlgqA7G56a6PwxWWAQ6CsHHdxQ1xo3Serigkhys2hmwRq+e
WPVrDSVRQLzOj/Qg6MsF2PPzdL5aNjK2QeHnWVcyXvfwZDhDCJKzz2iJC/ENjFNW
X2bD3wazu6A+aFsxjLHtf5wAa0+PhppcEhUZNSgQiC9SiT5DPFabLIIi7jgb0Nlg
v5GciAp1w0J+SUq2Wh4atrPR11Sj878AnJ872/Ku+pLseVu8h7N/60p8OwBm47Ak
GNZlgq7XF1lien/3eFq9mfJKGc97MxveEkiqI46ankVs+bDQOlUbXriMlINEeT8r
AzCar8pYx5W/xFb/gvYPnksATlOxLAaQ1jPZ1j0dIRaPtoOngtQ64TC5alRirGCK
uqQ7c1Soj7D3SjahrbQkoqcyODmRoC/55Pu8Klb2l96S91rSRtvca+EV05GNXmyN
eaArdGNuWPmzq6E8mQj3YrYnn18Z/x3WRr77xGVTAjUCGDPCE01+o/0G9P/+4cpv
olMs1/ludL/WzbBe9scp2JK442dGwE/pcBiWI34DmxbLZTb1baG4BEX6mbDdfnpk
SmIQv1RcHtbf16nvuhg+QVXnjAL5qQNiGVWxF9PTH8799wmcsdM=
=/KY9
-----END PGP SIGNATURE-----

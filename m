Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD234626AAA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiKLQpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiKLQpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:45:01 -0500
X-Greylist: delayed 456 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Nov 2022 08:44:58 PST
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFAB17064
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 08:44:57 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A129B7E14ED;
        Sat, 12 Nov 2022 16:37:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a241.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2A3D67E11F6;
        Sat, 12 Nov 2022 16:37:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668271037; a=rsa-sha256;
        cv=none;
        b=Gmz0q2EC7TG0HoDArFAxbgxDmdba1pbRuzfEyas3gMfzN34aRO/07LQTm27+1coibqYQSL
        fcsMWOCnqmA6Jy8jmmL/7iWHnIDDF/6w9e1gSiuMRrZlwFzpxpiVP1CfzYx9tn02Ph2Z9x
        HC0S/LkFXF+0vhRbQBTAjZTKSYj+dmNl9aSBzrCh0DoC/Kd/bNahQcP/xN5cASZq5u+5os
        bV3XlpJjAJObn3WII7NmLGgQ4QQZmic9Ha5SqLMy0/ZSn0LZCyj2wOF4Yyg0cXreEGvClV
        XWb1edh0mcHLH33VY6KjY6DJLStDSyYawv6pZq3uFnjsjF+HS/0xsszno7ncyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668271037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=BgjDRUXpzdiJriELDVGw8SLgCUCfYx0kRho3Yjy7mgQ=;
        b=qyF36bMuI+qiNrS2HVTIZFLEk6KmPlslwBfMJ6BTtxMavLiYk8oQliDDqv3q9GFwbn9g9Q
        kdbBQB2uwRqDnQweS4llDUITHNFSlwg9Pxi5VcE1euEZcI0rJacSG903vvYm9cM8kEsIRg
        4+b8JSuaclMe+Ac+MA2NiDpotMAkWlZFh/J7OwBRBInmrG4KRtBx6QFsqNEwcjcB+H7fwQ
        tUHT20TG5uKZwJ/kyx6hcPgXNe7v9NIIBiZu6ZhIznoOBIGh+GtSp+SZ4+Vgau4Oi0AJLr
        +ESd6edXzjKfo9TOyNNSm6nZaN0YUeCsy6MIo5EV/yIaXp6H/IeSWnmH3GoTZA==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-84scr;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Squirrel-Stretch: 2a467fd87fecc014_1668271037473_2029597070
X-MC-Loop-Signature: 1668271037473:154212069
X-MC-Ingress-Time: 1668271037473
Received: from pdx1-sub0-mail-a241.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.71 (trex/6.7.1);
        Sat, 12 Nov 2022 16:37:17 +0000
Received: from rhino (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a241.dreamhost.com (Postfix) with ESMTPSA id 4N8h7J0Pvcz2F;
        Sat, 12 Nov 2022 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668271036;
        bh=BgjDRUXpzdiJriELDVGw8SLgCUCfYx0kRho3Yjy7mgQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=I/oF149PzMbJZPcxOgJDsqzq++dX7exG73gHNdVfAgd/Qfi4o0Jtz8TrWWEO5/3QT
         rWIRjFMQFFVSovbu74lMznLxKtK7RC2zBJ43tO5zLOLe9cglkO8ZxOGU3BFZeJE5Gg
         32Z102edYF1zoAnRDjEACjzla90aJLhCN6FBxcV402eBPBtwyZ9qlhPPoizQ6kKHXz
         816fD/FJ4p3Xz7mM02MxtdhNE+GIe5gIRDrcQd7ZvUazJ579OEUX53FNmoidthWRcL
         ZGzpqKnyH1ioU0gY+YaxiVX5VmQceUrL6FtQn6FUEiIANEoSxZZgZVkEchTvi6rjMp
         1I+l9RWkJSUyA==
Date:   Sat, 12 Nov 2022 11:37:14 -0500
From:   Ian Cowan <ian@linux.cowan.aero>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ian@linux.cowan.aero
Subject: include: linux: slab: kmalloc_trace undefined when compiling drivers
Message-ID: <Y2/Luovqgz8O+Kqa@rhino>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling drivers (speficially drivers/pci/hotplug), I am receiving
the following modpost error for both `kmalloc_trace` and
`kmalloc_node_trace` on the staging/staging-next branch:

ERROR: modpost: "kmalloc_trace" [drivers/pci/hotplug/acpiphp_ibm.ko] undefined!

This only occurs when I have 'CONFIG_TRACING=y' in my config, and I
have traced it down to the slab header where the kmalloc_trace is
defined. It appears that when CONFIG_TRACING is set, the kmalloc_trace
and kmalloc_node_trace do not get defined by the compiler. I do not have
enough context in this area of the code base to propose a fix or to even
know if maybe it's a local compiling issue for myself. It looks like
there are a few recent commits from August that did some refactoring in this header,
and when compiling prior to that refactoring I am able to compile the
specified drivers without error.

I will mention that I am using Red Hat gcc version 12.2.1 and make version
4.3 and am on Fedora.

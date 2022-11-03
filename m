Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB376175FB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKCFGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiKCFGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:06:00 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DD818387;
        Wed,  2 Nov 2022 22:05:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7462C32008FF;
        Thu,  3 Nov 2022 01:05:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 03 Nov 2022 01:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667451954; x=1667538354; bh=RBxPaXEPLN
        X4kZR/Tfbq6PM+htPjUpWoWE03QVW+h88=; b=MRJ5Cs1PR8XbKbls2o00CqQNxa
        oHIW7WU43yk3ZSpsS6DZje2dbVAqIri0RVpnYsGUnRv9kM/iEPbZfMx/lraQiu78
        f3R2zbVjt1EqSw8Gipeb8EHcvDhxXTcAacWSdShahVDjFfr9iCfdOQYu9udv2UEi
        YCmfb83JEmyJqBME07gyaLLtckNG0WcZ25AUYX/GA67othMObU5eWmaY9SRJIj/4
        6LQ0ey9aQJcVB10iiNNmFTcEqaEvxIb7hw1FpfudqE5mZibIyy/shKn+hC+A+T/G
        /a9Bm4wZ+BJfOeolQPD7bI4k511v9DnBs01EK7CzCcyHn/6+za6L+pI6iFng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1667451954; x=1667538354; bh=RBxPaXEPLNX4kZR/Tfbq6PM+htPjUpWoWE0
        3QVW+h88=; b=GnA7BnDg4JFLorf9t7Z+DZKT+swVpWFWHmSRjEBzEjAMmuUDGLe
        GgVNm18d8ahMxwbXWRaYvhi1m+8EPZs6y4t59vR8gz9NC8SElpPG5skLd+IbqYWx
        o6tGt7kop6sDmMoUscSaNLGt4F7IsSj8AomEFhnLV9unncuEWv8WeNvwE50HsLHR
        FLatt52VDZ4FUi3LlB8WF+4ufHMy7M/OrDCq+NkgW9NcRvRwepGsdcDeP5G7xuF9
        WKsBhXFjIB40IGyWNjxeUoRXjj1TX0vYVYkkLGN8WjEbO8RIQhSba+4dpqxHjERx
        eNIdChenb+L5n7ShaFrd1z/qMpU8AWwZG3A==
X-ME-Sender: <xms:MUxjY15tF3Dswo0sX3yjHt1eWEpj2TAZK7jthZmHXi4ZnO-xbwUkVg>
    <xme:MUxjYy4h2mS8MdHXIVPnQqBn8P8ZywCsnICfBTpGw6zjIHise9O1BXE8XFml8dpGp
    cCkNJWXD_6rn0i3kw>
X-ME-Received: <xmr:MUxjY8fMd1wH7AxY4a8_6R1quwpZXx2YgfqwAH62cW435lS5E1_FzUwHP_ptCMRUtJbqKjB5MNl6KZzDVGHZcjvzDwyT8jr5jgGeODLdNjZ2Q6fe41joLNCaw5pKNkL7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudekgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhhnhcuvfhh
    ohhmshhonhcuoehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtghomh
    drrghuqeenucggtffrrghtthgvrhhnpeetjeevgffggeekffduledthfevgfeugeelhfeu
    veeiueekgfegffetudevhfdutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdr
    tghomhdrrghu
X-ME-Proxy: <xmx:MUxjY-JmVJ_Ino7uMRoWCNnUKBPd1XlavCm6i2KVJbhMzvFMzndJkw>
    <xmx:MUxjY5Ke-rt0Ot5czg81QzMOuT5SSK3p1IsFRPayWI7dTuC3ZKdUhQ>
    <xmx:MUxjY3xMq3_ezCJ-5uVZP6OiJiEMxGEZ6SFgiU3m9-Wgeh_hxJFhcQ>
    <xmx:MkxjY2FR2jSmdRmhgwH-t73SAEGh0rDjlGNl8l8Y5Xb1b-oIYGCo4g>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Nov 2022 01:05:51 -0400 (EDT)
From:   John Thomson <git@johnthomson.fastmail.com.au>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] mips: ralink: mt7621: fix too-early kzalloc
Date:   Thu,  3 Nov 2022 15:05:35 +1000
Message-Id: <20221103050538.1930758-1-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ralink mt7621 attempts to use kzalloc before normal memory management is
available.
Before v6.1-rc1, mt7621.c soc_dev_init silently failed to kzalloc and
returned in soc_dev_init, but continued to boot without the soc device
registered.
After, kernel crashes before it outputs any console messages

This was bisected to an mm/slub change (detailed in patch 3)

RFC due to
- probably a (much) better way to do this
- do not have mt7621 device with PCIe to test
  drivers/phy/ralink/phy-mt7621-pci.c
- should this reference a commit as Fixes?




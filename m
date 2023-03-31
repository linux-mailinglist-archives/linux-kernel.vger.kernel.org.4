Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2E46D17E4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCaG6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCaG6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:58:14 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC40A5C8;
        Thu, 30 Mar 2023 23:58:13 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E691D5C0069;
        Fri, 31 Mar 2023 02:58:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 31 Mar 2023 02:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680245889; x=1680332289; bh=8IpmWURAGLXzpk2/68wVTrU3Oyo9uKazty3
        0tpmDzO8=; b=akT/HpRjKbLjMjGic77CXRJ5Yi+oFj9PN4me1PCdCMOMc4hrbKz
        pon9d19Ui6iwjn2Bt0C9/dldJDdu2BvcS+zblwdCuGATk+6/oubPGOUwQzbShp18
        PdHo6tUCf8iNI0xRTF+TpKCtJaCOM5rmlo6QQHlP4BTEUTCnmGIr8K0qy2RC+nLY
        7xzTCRGRzYZ8oGXiCnc9sI+UW2w7XsqlVLDiPRPfj3UmCnVzwu7igAwAJikxZNCc
        ZaQocA4mY3C+/oNghQu8nC4aUteiOlxp8SqEViGzXhFvHlnRCx6zg70T8oSaM9bk
        QDLxcgBe7stGsVFVZ9Ic8j6uHg9ivM4/PEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680245889; x=1680332289; bh=8IpmWURAGLXzpk2/68wVTrU3Oyo9uKazty3
        0tpmDzO8=; b=uQWSX4t0M2WL3SHmjSkDwV9Q5JVgB5CcJnwnd7EG0kenju0YRXV
        Rb+jnQ5W47pKUgunSPOaca61D27Aq6r1LpeRUGeSv2wUM3breBX5tnIF1pPjwVyk
        G4bKzcptdQL2M0xF/9eX3dpSLJukIlm8e5IJhgeSnfKsSgKeoEwZmRxd2QvKbKD6
        G6hwjTIUPDoCwmmyQQg/yXA78zr5UhCZGm9QGLOenySs56hHxy5yi34O+28yuTSu
        XZ/qxdQbpEqvY5kv62nqUROCQgMz02OM3xdGMZq682EXiXVXDZQxe/NgVj1Rrn3n
        FzJI55UvOONClqei6vQUnEJHGwF+PLw1gnw==
X-ME-Sender: <xms:gYQmZMXUUG8_5v5RJFJaosFUjuCCJmAe8yBoGS0Dkfr-4GOeW17xfA>
    <xme:gYQmZAmyJUg0Z0bKMjPxh8YxwhpptWyLrxQ6DKrmsD-Laxu_JsSuarH9do9-db0jC
    uUIGVZT6ZBsDdYZ4g>
X-ME-Received: <xmr:gYQmZAY8rXt8SruSDyXnjWYhoGCS8uR-xcIHoabkvsXfH13yMf0E7ysngIfW8HoaI23RC4J2nLxY7dt_3bwb_2b3zA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeitddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epheduuddvteekvdektdduledugfffhfdugeejgeeuvdevtdetveejheehiefffeegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:gYQmZLVeGxufjlbym8N4cWhhbRKTaPuI8lmNDOjRp6t3o-zk5ZAMEg>
    <xmx:gYQmZGm13aKEv4Xx2F6TarPsU_0hwnj4Nwt1FS_No4uZnP1W7GT7RA>
    <xmx:gYQmZAcwFVViOP5hBpQYnt9PzSLhy3IEVVp7IaotYN6jYA3fHHQ8MQ>
    <xmx:gYQmZA4y22s5LxhIz7KjE6haUnSiFhRAR8Yg2X2Qpg7uyV44nosVXg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 02:58:07 -0400 (EDT)
Message-ID: <e93426bb-cc4a-c52b-5a9b-3416f9012b45@ryhl.io>
Date:   Fri, 31 Mar 2023 08:58:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 10/13] rust: prelude: add `pin-init` API items to
 prelude
Content-Language: en-US
To:     y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>
References: <20230329223239.138757-11-y86-dev@protonmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230329223239.138757-11-y86-dev@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 00:33, y86-dev@protonmail.com wrote:
> From: Benno Lossin <y86-dev@protonmail.com>
> 
> Add `pin-init` API macros and traits to the prelude.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2F26EE95C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 23:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbjDYVJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 17:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjDYVI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 17:08:58 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8D5FD7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 14:08:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E0E465C015B;
        Tue, 25 Apr 2023 17:08:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 25 Apr 2023 17:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1682456933; x=1682543333; bh=UTETzbNeaebnjEnuPs2LB2094tfedUSx+OQ
        HXYRu7zI=; b=MeIAMmpJBjPtZbI7XGjyeQ4jEpHJKMENySze7T+fZQmIJ0/JjlU
        6YOeNMKHxBlgCIXRg7d8lRQaL82/IDdjthhaUxYCJws3mdYevSLpYA7p7sw8o8Y5
        JVWqjjIce2Ub8xa4ChSLjDDKGbYTGUoV/terBUEDVDvralts4io7QVTQjmseSV7V
        7JF4P7cJpIBc/nFY4V6YIdSZiD7A5wpdse7sOHtgqMnr2MjSZ6GWeHHyOSaHcjy3
        vmji/m04FR1BE+fCsp6tAfSnwnwo98ooixnZJDsKQ2xTt7iyuzldYRycqXFzSCUm
        eGiNZj7D/kXCXecyD4GkcQTOpNjkFoQj3dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682456933; x=1682543333; bh=UTETzbNeaebnjEnuPs2LB2094tfedUSx+OQ
        HXYRu7zI=; b=YCphXXQjqDjr253QytdGWILhkFw5E5msjt9ogVaDdFNB1xNM6wf
        eVxL0gHlAi22M2b7rPQTyL4g5EAUQln11ONtuz2p4YGMiE8UOF9bAcc9zLo71xdw
        eG6giL9cYJSqpm68bemf7TIdc/sIr4WBiJSfVcIfgkp2iy+MtG0nUborxJUZaMgu
        oo3GuqghXgIJVYJ9jp8s5lPPGUovcWgrGs4sFlTuvTD4TmhDE1IdJI67Z0RSwzPs
        Xghzv/Kmy2TyviPgGGn730ZVWriHVIcwiSgG/kXOtBo0uzyKDgZsoPqsMIZgpuP9
        yRPC+nroyo0NpelQoAhDqbtPJuwaHBIT81w==
X-ME-Sender: <xms:ZUFIZHPn1dnmEeWg7k4jVd8k1zCwF09o9ffXUP_L6QWJjukZBdVOmw>
    <xme:ZUFIZB_6_k3ieCgwKgy0UtU4BDm2Qdt2TnNpxJpofoCgDAv9Dqkle0m12mY3jIvyB
    Ssd20yfquPx5d8nLA8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduvddgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ZUFIZGSxPLgjM2tuVYCCD-bCKqGwVd7lcx1GLYgrFNzOYL_ezDzg5Q>
    <xmx:ZUFIZLvLSn5UbtyzX5I9DxpLPd1XqFeMCpEjXI7QFccooqK-oJ_JUQ>
    <xmx:ZUFIZPeEii9QE9ye97ONsIJN_9eXW8M2nSpSl16xUR6WTdncCMqt-g>
    <xmx:ZUFIZHFzi27lyq_X_bqwx0RG_XDG2KHOXn0b098Qvdw7Mq-LozDpjQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 90FFCB60086; Tue, 25 Apr 2023 17:08:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <305e89e6-dd02-4309-844a-3237723c5707@app.fastmail.com>
In-Reply-To: <CAHk-=wgMmTo=SL1URex5kQbhwGhfBy541tbNbLXrYniAnTxvew@mail.gmail.com>
References: <bbd25997-173e-4c3b-930c-65c6232908e3@app.fastmail.com>
 <3579080b-db88-493c-a260-7313a81e2aa3@app.fastmail.com>
 <CAHk-=wgMmTo=SL1URex5kQbhwGhfBy541tbNbLXrYniAnTxvew@mail.gmail.com>
Date:   Tue, 25 Apr 2023 22:08:53 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 4/4] ARM: SoC devicetree changes for 6.4
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023, at 20:21, Linus Torvalds wrote:
> On Mon, Apr 24, 2023 at 2:06=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>>
>> ARM: SoC devicetree changes for 6.4
>
> Hmm. This also has commit e49eabe3e13f ("pinctrl: qcom: Support
> OUTPUT_ENABLE; deprecate INPUT_ENABLE") that doesn't seem to be
> obviously about devicetree changes.
>
> Whatever. I took the pull, but that change looked oddly out of place..

Right, this was a commit that is also in the pinctrl tree, and
Bjorn pulled it into the qcom/dt tree to make sure this can be
properly bisected. As the patch description explains, the driver
did not implement the binding correctly, so changing it like this
at least keeps compatibility in one direction (old DTB with new
kernel) while fixing both the driver and the dts files to work
with the documented binding.

Normally this should not be necessary as long as we keep
compatibility both ways, but I trust that Bjorn was confident
this would not cause problems here.

     Arnd

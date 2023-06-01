Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01208719FDF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjFAO0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjFAO0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:26:09 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7170FC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:26:05 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DBC7B3200928;
        Thu,  1 Jun 2023 10:26:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 01 Jun 2023 10:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685629563; x=1685715963; bh=KWRLPe4QiP
        /istjgW6FING88PTnKvxe+DScyuXcEQH4=; b=Bm9NHy0h2tv+fDEdVSncH3u7Ei
        lq/ISO1ts6DMNa1zO7cjqYl+aPzdhRjRJACmkqnnMyHbRmjs65TmkEmlqd1ooGud
        XMr7g+PZLlFv4pKae9V/QL/gqgNgyMJFPNkadUpINIw9tpPmVAy7zW18zbHH1B17
        LjHCHStQU7heUssAWl7stZsDa7tD6yX29MB42t+NNvvWj1nZ8wlrrEvtE37anw06
        FsCDroc/LkxyM9lwHcbUeFHpfO6fmycM53N4uQy0T8OmqpkuFuiB+1aRJ/Lv97Ns
        pbssx+QYaIYMyllxpU9/1ibFHh4WiLUArENyoMV/uuRxmHMypEVBwl5s+QQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685629563; x=1685715963; bh=KWRLPe4QiP/istjgW6FING88PTnKvxe+DSc
        yuXcEQH4=; b=EiRGnA04fIvKknuLwujsjqRy74164umqmdPX/lPNGfslk8syuT4
        w40tBkAawjcG2Fd+eM857wu3HflKEJwaX3dAwzfDcfPhbzLxI/VartOkrpPFFm6s
        W3c9c3uYwiNfLP170bHF3NfcCazO8vlvC2Tkstr69MtQzhQ5LG1Uz3WpPGsuNH0i
        0sFoPzlSksvL0xpqqq0msII/hiIz/mFcGD98IHdG/cbHwFz9/jyFats437ECdOpk
        LDQi8I45k83QoyBA6GFuP8osQB6seGxfRxQFnMuuIp2aNfamkHiwU62ChRkATSrX
        1gX35j4BFc/yTsjSQYOLJmooMaI5o1fACEg==
X-ME-Sender: <xms:eqp4ZG7Um7vkC5J0TfqVL5Ib5elUIi6bGdmx1lljwYS9EdwadegvQw>
    <xme:eqp4ZP5ikmOm7qlhJDE_WXplGOgivY37H0jN7FTQ1OHWi4nfgdDAm19cxTJ1RME0v
    4uPur2QqC4ADKihk4g>
X-ME-Received: <xmr:eqp4ZFeyzGdJhbUsKa0kNgdIxiIOI_3Odf2J0b2Rkzj2tYjhyYJqH7Id6BcIsVxSdoCFqC1xP62YyctU1rky11eCFHTuWZHlaQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefve
    egvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:eqp4ZDKFeTmJghD_O2-EowoPyNDqtau24DDtSpkb76-7tRGpAFufIQ>
    <xmx:eqp4ZKJmxAhe5a6rb2Cwy2DYDfnNQ3_O6tg9IMcN51-axPZILNkUew>
    <xmx:eqp4ZEzbE8pyqnP2SguyfQ_kCb9XUsPyH1eu7-cqP3v8TERE_7GXPg>
    <xmx:e6p4ZEwjB3wefIijXVXN3-obITkLnhhtyobdjW3Kn47OeR4XYzFl6A>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 10:26:01 -0400 (EDT)
Date:   Thu, 1 Jun 2023 23:25:59 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: firewire fixes for 6.4-rc4
Message-ID: <20230601142559.GA118570@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.4-rc4

for you to fetch changes up to 4420528254153189c70b6267593e445dc8654e37:

  firewire: Replace zero-length array with flexible-array member (2023-06-01 22:41:14 +0900)

----------------------------------------------------------------
firewire fixes for 6.4-rc4

This pull request includes a single patch from the project for consecutive
effort of memory safety array. It brings no change to user space, thus it
is worth to apply it as a fix.

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      firewire: Replace zero-length array with flexible-array member

 include/linux/firewire.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


Regards

Takashi Sakamoto

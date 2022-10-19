Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4112B604521
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiJSMWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiJSMVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:21:11 -0400
Received: from ggeceazg.iranichat.com (unknown [92.52.217.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68E7102532
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=iranichat.com;
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-Description:Subject:To:From:Date:Message-ID; i=fin.bee@iranichat.com;
 bh=SnzvvH6uGl2MiFnmR3uhYIQGwXE=;
 b=ByhHYoeAjS/7rybAhn6wbfxP2m55gB8Yg0Y5wia2RsQ2bMGo97Om16COHay3qPJlIXjFMYVcpd/L
   yLSx/wn8WM30IiOQx5I1nLRhUV2p+p2b9YDRHn7GiCtVeOHSxgJhwdQ1Jsaj41f/Ze6ChX52/nAW
   TjKFNi1jzkUetpr0SeO+n37+S1zyDkKz9wZ1yLtofGGp2dvSNB7rZsHQR6B0N5Fkv7Rif18OGxz2
   +gKXaOInIt5ROG92HDCQ6cFM5llMi/dVGBEM1HJAWSCFORaal5PDgnmfT4TQQkxi+fS/ajwzTw4c
   leyqiZFMeiYh3E3T+oanUFoHbPqsZRa+ePt6aw==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=iranichat.com;
 b=gpl9WkuePxvsX3MvWBO3ZSlnqxzzDhs3eKT/y2axHoq0GzAWYjuqmA4qkbDUlNX0XRBsgpKLNl+0
   hhGfEEPIq4O3vSs4Uh9CM7J4EgR/mh4CpHfSIIJn3/lye1Snxk0MkpX6d4Age556+lyV3gcXSkTJ
   Wkvf9OEaGkKaQVQdbtzDZ0r33uFjnN9bNLeuh6wC7LRGpha46WLUNlT9LZIIw/ptiv54XObklmvg
   hl1Rxm7ZJ6/JtoZX/SKWq4nW8Q2AH4dF18uCNluFAiQ0qK5hQeXrgxwTbsguVUkSOIQ6AxDLCy8L
   xP73FqUyQyVXvoADSDBIkU7ZasgVa7rzw/Fjdg==;
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: New order
To:     Recipients <fin.bee@iranichat.com>
From:   "fin.bee@iranichat.com" <fin.bee@iranichat.com>
Date:   Wed, 19 Oct 2022 13:53:57 +0200
Message-ID: <0.0.1.7DC.1D8E3B17BF35CA6.0@ggeceazg.iranichat.com>
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.7 URIBL_BLACK Contains an URL listed in the URIBL blacklist
        *      [URIs: iranichat.com]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
        *  1.0 TO_EQ_FM_DIRECT_MX To == From and direct-to-MX
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,
Please I will like to request a quote from your company.

Let me know so I can send you our order list to quote for us.

I await your response.

Thanks,

-

Mit freundlichen Gr=FC=DFen / Kind regards

Maria Andran

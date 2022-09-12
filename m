Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ACA5B63C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiILWfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiILWfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:35:48 -0400
Received: from burlywood.elm.relay.mailchannels.net (burlywood.elm.relay.mailchannels.net [23.83.212.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469FE2A721
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:35:46 -0700 (PDT)
X-Sender-Id: techassets|x-authuser|leesusan20@ingodihop.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A2FF16C2F07;
        Mon, 12 Sep 2022 22:35:45 +0000 (UTC)
Received: from vmcp128.myhostcenter.com (unknown [127.0.0.6])
        (Authenticated sender: techassets)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4B5C86C2E07;
        Mon, 12 Sep 2022 22:35:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663022145; a=rsa-sha256;
        cv=none;
        b=J9Gv6F+khH74rb7PUXhRZ/ZvvgOJgLukeBAKlMfJs7mw/ElccgCGL+HB7MyypoF2nD0zxx
        pnXFPC4kYJ459TMzlBf8J/w6bQHpdNt4idddcV2VPCxRdVIoHuDV0nQhKQiA2VwmS0GiiU
        C37Bu2m9LwEOQzUsm/cFXyZ9p4HiTfH6nGpGNvoV7CjSR8Jb6j9rBO+eLUgEX9ZGfEdfJP
        Yvg+k/PPCoicSENiLuCP6iZMsay6NeymXKo+ODXDAuOc+hEXbLUN/Ex2gmWoL9kYn20l75
        ojDxuOyQQoxcLiexLAmep5hp6io1quR1X3nosa8LLc29mpqjFiLubva9B8OPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663022145;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hXLnhYIY6RPq2jPDah+snLlNw2/6UxQIEbgnwiMYIN0=;
        b=ZYUOGB+NBKL+zpsdLmWd6tmd7x5xjUoHEV16hl5z3sKDPfGHBPpCaGLbik6ERWEJ/2s/2B
        lvXDwFZqcUyZNmzOvKDJuB9x0fVicr9QWvelAoogELics34Gup/LjNFOZoe2TciGb/jvwL
        LjV9i3L+8nBq7MPRhoVSfVdHzhq0SHCyZqgqoYjAtP1a9UyCoJLtkdUdbmD30uRnCTzGP+
        inczMxCKyrl5RdnZAIL7CFlohMh4jR4gfDD0kqBQ7IbUTSUXiqjxYZmvuEnZKaCNPBsrxd
        VIFQRjv5lr5IRD6947mwjuAhJ0OigZf9QQTMZVDBHSWwvdG5Jlh422cwM3lYwA==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-mszcr;
        auth=pass smtp.auth=techassets smtp.mailfrom=leesusan20@ingodihop.com
X-Sender-Id: techassets|x-authuser|leesusan20@ingodihop.com
X-MC-Relay: Junk
X-MailChannels-SenderId: techassets|x-authuser|leesusan20@ingodihop.com
X-MailChannels-Auth-Id: techassets
X-Stretch-Lonely: 0aa130bb4eef4538_1663022145140_2105050998
X-MC-Loop-Signature: 1663022145140:2942180376
X-MC-Ingress-Time: 1663022145140
Received: from vmcp128.myhostcenter.com (vmcp128.myhostcenter.com
 [66.84.29.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.98.207.176 (trex/6.7.1);
        Mon, 12 Sep 2022 22:35:45 +0000
Received: from [::1] (port=45846 helo=vmcp128.myhostcenter.com)
        by vmcp128.myhostcenter.com with esmtpa (Exim 4.95)
        (envelope-from <leesusan20@ingodihop.com>)
        id 1oXs1T-00C9fg-Ui;
        Mon, 12 Sep 2022 18:35:23 -0400
MIME-Version: 1.0
Date:   Mon, 12 Sep 2022 18:35:10 -0400
From:   "Mrs. Susan Lee Yu-Chen" <leesusan20@ingodihop.com>
To:     undisclosed-recipients:;
Subject: Mrs. Susan Lee Yu-Chen
Reply-To: mrs.susanlee22@gmail.com
Mail-Reply-To: mrs.susanlee22@gmail.com
User-Agent: Roundcube Webmail/1.5.2
Message-ID: <6544f0bc496c3ea60388af1756b2ac9c@ingodihop.com>
X-Sender: leesusan20@ingodihop.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AuthUser: leesusan20@ingodihop.com
X-Originating-IP: ::1
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,HK_NAME_MR_MRS,
        ODD_FREEM_REPTO,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrs.susanlee22[at]gmail.com]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [23.83.212.26 listed in wl.mailspike.net]
        *  0.0 T_SPF_PERMERROR SPF: test of record failed (permerror)
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.5 ODD_FREEM_REPTO Has unusual reply-to header
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 HK_NAME_MR_MRS No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-- 
Dear Friend,
  It’s just my urgent need for foreign partner that made me to contact 
you via your email. The details will send to you as soon as i heard from 
you.
Mrs. Susan Lee Yu-Chen

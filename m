Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CFB708AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjERVyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjERVxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:53:54 -0400
X-Greylist: delayed 361 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 May 2023 14:53:45 PDT
Received: from mx2.jinr.ru (mx2.jinr.ru [159.93.14.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BCA10D8
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:53:45 -0700 (PDT)
Received: from mx2.jinr.ru (localhost.localdomain [127.0.0.1])
        by mx2.jinr.ru (Proxmox) with ESMTP id 4621B1211CA;
        Fri, 19 May 2023 00:47:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jinr.ru; s=mail;
        t=1684446460; bh=P/HTwxG7tDxJ6dVGmM9PLq7bLGbc1/kzeUuw2/tEtGM=;
        h=Date:From:To:Reply-To:From;
        b=RhsWwuVkEKydXMh8umaHhGSo6NRumemouneoa0VAteWk2sTjjCiiL7FEte+dUjs2z
         /Xp2JWKwx/McneIhOVJOsPzeR5XAS+fOk1DOTBxaCxXd04bdQjrFBt3HckRumo04z5
         ixlgTBhNUkdOekM+Sl6oKHIVylMabbtJZPRV2PYQ=
X-Virus-Scanned: Debian amavisd-new at jinr.ru
MIME-Version: 1.0
Date:   Thu, 18 May 2023 22:47:33 +0100
From:   Rowell <usi@jinr.ru>
To:     undisclosed-recipients:;
Reply-To: rowellhambrick4@aol.com
Mail-Reply-To: rowellhambrick4@aol.com
User-Agent: JINR Webmail/1.5.3
Message-ID: <703198d92bc42770e2d6fccac3a9da59@jinr.ru>
X-Sender: usi@jinr.ru
Organization: =?UTF-8?Q?=D0=A3=D0=A1=D0=98_=D0=9E=D0=98=D0=AF=D0=98?=
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_SUBJECT,ODD_FREEM_REPTO,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5068]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rowellhambrick4[at]aol.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  1.8 MISSING_SUBJECT Missing Subject: header
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 ODD_FREEM_REPTO Has unusual reply-to header
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Did you get my mail


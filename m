Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91288712DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbjEZTsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjEZTsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:48:37 -0400
Received: from mcarnes.com.br (mx01.mcarnes.com.br [143.255.12.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67888B6
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:48:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mcarnes.com.br (Postfix) with ESMTP id BA26943D6572
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:25:38 -0300 (-03)
Received: from mcarnes.com.br ([127.0.0.1])
        by localhost (mcarnes.com.br [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id q6o2TMr7ak2W for <linux-kernel@vger.kernel.org>;
        Fri, 26 May 2023 16:25:38 -0300 (-03)
Received: from localhost (localhost [127.0.0.1])
        by mcarnes.com.br (Postfix) with ESMTP id 2FEC743B3E44
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:25:38 -0300 (-03)
DKIM-Filter: OpenDKIM Filter v2.10.3 mcarnes.com.br 2FEC743B3E44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcarnes.com.br;
        s=57560CA4-14EE-11ED-BE35-8FFAC263C415; t=1685129138;
        bh=diWNn7p0TKlEirbLy6B4RNRI9lY4V0b+Ulc0eN/p0Iw=;
        h=From:To:Date:Message-ID:MIME-Version;
        b=BqeuOTu5kRM2HKTM/62pyXvBat50qJ7ABx4/TF7mgMlv+uVyrpW9R8PVQTBpW0bBe
         DY/Y/0tqrilGPMRuTEEOy9VLFI7hs2tH7fSqhj1UQS0JklZoW9ihmTw0tyCXxYPEpq
         DD+RkPhIrwiPePnZ34bUxiMrVhUXK1clt1E6eInrMOkujuFWVO2hUJzhOO8I1LRe6W
         uyh5vKBjAo8xHFWKwIr/1ojOxXF6OF3pTwV4N8fsFgQ2gijUa/31qEPItSt785gyja
         vcbz24xvd+g4np+iYO3hiQolCs4XNLUfaUHfD75K5ZTEXXBluM7fnx77OrHVTR3GD9
         8AYtHKr1lStnA==
X-Virus-Scanned: amavisd-new at mcarnes.com.br
Received: from mcarnes.com.br ([127.0.0.1])
        by localhost (mcarnes.com.br [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TUx-A95zygQ1 for <linux-kernel@vger.kernel.org>;
        Fri, 26 May 2023 16:25:38 -0300 (-03)
Received: from [93.95.27.154] (unknown [93.95.27.154])
        by mcarnes.com.br (Postfix) with ESMTPSA id 4FC3C436B790
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:25:37 -0300 (-03)
Reply-To: bahrainorganization@gmail.com
From:   katia@mcarnes.com.br
To:     linux-kernel@vger.kernel.org
Subject: Hello
Date:   26 May 2023 12:25:33 -0700
Message-ID: <20230526020042.2DCB9F536AABC3F6@mcarnes.com.br>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.7 required=5.0 tests=ADVANCE_FEE_4_NEW,BAYES_50,
        DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_BL_SPAMCOP_NET,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: mcarnes.com.br]
        *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?143.255.12.239>]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  2.3 ADVANCE_FEE_4_NEW Appears to be advance fee fraud (Nigerian
        *      419)
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are thrilled to inform you that you have won the grand prize=20
in our latest donation drawing! Congratulations!
Your ticket number [B912023-949] was selected as the lucky=20
winner, and you are now entitled to the grand prize ! We know=20
this will be a life-changing event for you, and we are equally=20
excited to share in your joy.
To claim your prize, please contact our customer service team=20
within the next 7 working days. They will guide you through the=20
process of claiming your prize, including the necessary paperwork=20
and identification requirements.
We look forward to hearing from you soon and once again,=20
congratulations on your win!
Best regards,
Alvin Louis
BAHRAIN GROUP

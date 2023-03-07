Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A796AE0FB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCGNol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCGNoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:44:18 -0500
X-Greylist: delayed 4351 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Mar 2023 05:43:06 PST
Received: from mail.belitungtimurkab.go.id (unknown [103.205.56.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BBE2942A;
        Tue,  7 Mar 2023 05:43:05 -0800 (PST)
Received: from mail.belitungtimurkab.go.id (localhost.localdomain [127.0.0.1])
        by mail.belitungtimurkab.go.id (Postfix) with ESMTPS id BC3138A700C;
        Tue,  7 Mar 2023 14:59:49 +0700 (WIB)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.belitungtimurkab.go.id (Postfix) with ESMTP id 3C3F68A5006;
        Tue,  7 Mar 2023 14:43:12 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.belitungtimurkab.go.id 3C3F68A5006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=belitungtimurkab.go.id; s=mail; t=1678174992;
        bh=1yQ6sMopnzyP9MqfXA851yTH5iXi+5F1MZ7Sp6JOGqk=;
        h=Date:From:Message-ID:MIME-Version;
        b=cWIOu3KKPNXyPgATk6HA3te214RWKMqlx4e5EfFPu3dFqlcYzZudfH2wpLCmrVI08
         nFyDYPdQvfPeI6FivksFbNns1f1keqpCfjwspx7vOIgaEXJiyeAXdxqdckKe5LtqOh
         M5TTDnOCVTyF2yZD+n9wF+zNJEudz+rDhPTnsrKIQsm8MYh8B5q1BGVvOfryzrymjY
         h36ot5evmptJ0NGT4cYY6XaB86xlcOJ1hQhrsuY/pNGlqMBqmt0jq/TX3/E97K3SGg
         sdTYg4TF7HSbhGP0/0XxP8Uasw9N4iHqBbv0QnTRZD+4G4gt3lb9ZCGV8HQEsu/u7X
         Kt82hZoXNz/5Q==
Received: from mail.belitungtimurkab.go.id ([127.0.0.1])
        by localhost (mail.belitungtimurkab.go.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yxFEx8rgsstj; Tue,  7 Mar 2023 14:43:11 +0700 (WIB)
Received: from mail.belitungtimurkab.go.id (mail.belitungtimurkab.go.id [103.205.56.27])
        by mail.belitungtimurkab.go.id (Postfix) with ESMTP id 0E8528A6A72;
        Tue,  7 Mar 2023 14:43:05 +0700 (WIB)
Date:   Tue, 7 Mar 2023 14:43:04 +0700 (WIB)
From:   =?utf-8?B?INCh0LjRgdGC0LXQvNC90YvQuSDQsNC00LzQuNC90LjRgdGC0YDQsNGC0L7RgA==?= 
        <dinkes@belitungtimurkab.go.id>
Reply-To: sistemassadmins@mail2engineer.com
Message-ID: <1909914973.29538.1678174984936.JavaMail.zimbra@belitungtimurkab.go.id>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Originating-IP: [103.205.56.27]
X-Mailer: Zimbra 8.7.11_GA_3789 (zclient/8.7.11_GA_3789)
Thread-Index: Yuws0KvB5P8LfkgJLrQpfFdkkbfUkg==
Thread-Topic: 
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        MISSING_HEADERS,RDNS_NONE,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: belitungtimurkab.go.id]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.0 MISSING_HEADERS Missing To: header
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92=D0=9D=D0=98=D0=9C=D0=90=D0=9D=D0=98=D0=95;

=D0=92=D0=B0=D1=88 =D0=BF=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D1=8B=D0=B9 =D1=8F=
=D1=89=D0=B8=D0=BA =D0=BF=D1=80=D0=B5=D0=B2=D1=8B=D1=81=D0=B8=D0=BB =D0=BE=
=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D1=85=D1=80=
=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B0, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=
=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=
 5 =D0=93=D0=91, =D0=BA=D0=B0=D0=BA =D0=BE=D0=BF=D1=80=D0=B5=D0=B4=D0=B5=D0=
=BB=D0=B5=D0=BD=D0=BE =D0=B0=D0=B4=D0=BC=D0=B8=D0=BD=D0=B8=D1=81=D1=82=D1=
=80=D0=B0=D1=82=D0=BE=D1=80=D0=BE=D0=BC, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=
=8B=D0=B9 =D0=B2 =D0=BD=D0=B0=D1=81=D1=82=D0=BE=D1=8F=D1=89=D0=B5=D0=B5 =D0=
=B2=D1=80=D0=B5=D0=BC=D1=8F =D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=B5=D1=
=82 =D0=BD=D0=B0 10,9 =D0=93=D0=91, =D0=B2=D1=8B =D0=BD=D0=B5 =D1=81=D0=BC=
=D0=BE=D0=B6=D0=B5=D1=82=D0=B5 =D0=BE=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=
=D1=8F=D1=82=D1=8C =D0=B8=D0=BB=D0=B8 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B0=
=D1=82=D1=8C =D0=BD=D0=BE=D0=B2=D1=83=D1=8E =D0=BF=D0=BE=D1=87=D1=82=D1=83=
 =D0=B4=D0=BE =D1=82=D0=B5=D1=85 =D0=BF=D0=BE=D1=80, =D0=BF=D0=BE=D0=BA=D0=
=B0 =D0=BD=D0=B5 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D0=B5 =D0=
=BF=D0=BE=D1=87=D1=82=D1=83 =D0=BF=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D0=BE=D0=
=B3=D0=BE =D1=8F=D1=89=D0=B8=D0=BA=D0=B0 =D0=BF=D0=BE=D0=B2=D1=82=D0=BE=D1=
=80=D0=BD=D0=BE. =D0=A7=D1=82=D0=BE=D0=B1=D1=8B =D0=BF=D0=BE=D0=B2=D1=82=D0=
=BE=D1=80=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D1=
=8C =D1=81=D0=B2=D0=BE=D0=B9 =D0=BF=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D1=8B=D0=
=B9 =D1=8F=D1=89=D0=B8=D0=BA, =D0=BE=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D1=8C=D1=
=82=D0=B5 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D1=83=D1=8E =D0=B8=D0=
=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BD=D0=B8=D0=B6=D0=
=B5:

=D0=B8=D0=BC=D1=8F:
=D0=98=D0=BC=D1=8F =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=
=D0=B5=D0=BB=D1=8F:
=D0=BF=D0=B0=D1=80=D0=BE=D0=BB=D1=8C:
=D0=9F=D0=BE=D0=B4=D1=82=D0=B2=D0=B5=D1=80=D0=B4=D0=B8=D1=82=D0=B5 =D0=BF=
=D0=B0=D1=80=D0=BE=D0=BB=D1=8C:
=D0=AD=D0=BB=D0=B5=D0=BA=D1=82=D1=80=D0=BE=D0=BD=D0=BD=D0=B0=D1=8F =D0=BF=
=D0=BE=D1=87=D1=82=D0=B0:
=D0=A2=D0=B5=D0=BB=D0=B5=D1=84=D0=BE=D0=BD:

=D0=95=D1=81=D0=BB=D0=B8 =D0=B2=D1=8B =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=
=D1=82=D0=B5 =D0=BF=D0=BE=D0=B2=D1=82=D0=BE=D1=80=D0=BD=D0=BE =D0=BF=D1=80=
=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D1=8C =D1=81=D0=B2=D0=BE=D0=B9 =D0=BF=
=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D1=8B=D0=B9 =D1=8F=D1=89=D0=B8=D0=BA, =D0=B2=
=D0=B0=D1=88 =D0=BF=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D1=8B=D0=B9 =D1=8F=D1=89=
=D0=B8=D0=BA =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=BE=D1=82=D0=BA=D0=BB=D1=8E=
=D1=87=D0=B5=D0=BD!

=D0=9F=D1=80=D0=B8=D0=BD=D0=BE=D1=81=D0=B8=D0=BC =D0=B8=D0=B7=D0=B2=D0=B8=
=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B7=D0=B0 =D0=BD=D0=B5=D1=83=D0=B4=D0=BE=
=D0=B1=D1=81=D1=82=D0=B2=D0=B0.
=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BE=D1=87=D0=BD=D1=8B=D0=B9 =D0=BA=
=D0=BE=D0=B4: en: WEB. =D0=90=D0=94=D0=9C=D0=98=D0=9D=D0=98=D0=A1=D0=A2=D0=
=A0=D0=90=D0=A2=D0=9E=D0=A0=D0=90. RU006,524765 @2023 =D0=9F=D0=BE=D1=87=D1=
=82=D0=BE=D0=B2=D0=B0=D1=8F =D1=82=D0=B5=D1=85=D0=BD=D0=B8=D1=87=D0=B5=D1=
=81=D0=BA=D0=B0=D1=8F =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=
=B0 @2023

=D0=A1=D0=BF=D0=B0=D1=81=D0=B8=D0=B1=D0=BE
=D0=A1=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D0=BD=D1=8B=D0=B9 =D0=B0=D0=B4=D0=BC=
=D0=B8=D0=BD=D0=B8=D1=81=D1=82=D1=80=D0=B0=D1=82=D0=BE=D1=80.

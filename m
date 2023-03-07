Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5C46AE5DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCGQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjCGQEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:04:52 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB5A2DE79
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:03:06 -0800 (PST)
Date:   Tue, 07 Mar 2023 16:02:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atinb.me;
        s=protonmail; t=1678204981; x=1678464181;
        bh=JqGwO8iIDiHBUIEFwkqfcDo3Km+A5ml9VJBTDOpaqHM=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=aksGqreqNZ/JdljUicuXGY0uMXeJf7+6DbBRNXsaOYMWiEzQK7AL8Ozo7LRTcRDeR
         FCij8hQEOKpL7WAhQlZu/ATg2QspNhAhc2cHbrja7A8L60WztJvZACe9jc2l3MJqy7
         0QJjI+K17gcerC07pDQBeJQlQuhYQx2SHACYM6OfrRfptRFAsspBUT1WuPZ7dOINGC
         UpLtC+QBhw+Vh1W6HDQhWI6wt8tfOA0fVU/yr26KvE977PgLdOFaq8Ok1B4cKQzxr6
         ZtApaCK12AQVGOxlFeV2JJnGuJ12Fb+1gPzNVIPJYzM2iEOa7fOu6t4RMLvneM8NBT
         RRWCThE5JDBEA==
To:     gregkh@linuxfoundation.org
From:   Atin Bainada <hi@atinb.me>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        Atin Bainada <hi@atinb.me>
Subject: [PATCH] tty: do checkpatch cleanup
Message-ID: <20230307160232.1029705-1-hi@atinb.me>
Feedback-ID: 64551405:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Atin Bainada <hi@atinb.me>
---
 drivers/tty/tty_ioctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 12983ce4e43e..05a4dd0db476 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -73,7 +73,7 @@ EXPORT_SYMBOL(tty_chars_in_buffer);
  *=09the number of bytes written. If no method is provided 2K is always
  *=09returned and data may be lost as there will be no flow control.
  */
-
+
 unsigned int tty_write_room(struct tty_struct *tty)
 {
 =09if (tty->ops->write_room)
@@ -403,6 +403,7 @@ __weak int kernel_termios_to_user_termio(struct termio =
__user *termio,
 =09=09=09=09=09=09struct ktermios *termios)
 {
 =09struct termio v;
+
 =09memset(&v, 0, sizeof(struct termio));
 =09v.c_iflag =3D termios->c_iflag;
 =09v.c_oflag =3D termios->c_oflag;
@@ -540,6 +541,7 @@ static void copy_termios_locked(struct tty_struct *tty,=
 struct ktermios *kterm)
 static int get_termio(struct tty_struct *tty, struct termio __user *termio=
)
 {
 =09struct ktermios kterm;
+
 =09copy_termios(tty, &kterm);
 =09if (kernel_termios_to_user_termio(termio, &kterm))
 =09=09return -EFAULT;
@@ -919,6 +921,7 @@ static int __tty_perform_flush(struct tty_struct *tty, =
unsigned long arg)
 int tty_perform_flush(struct tty_struct *tty, unsigned long arg)
 {
 =09struct tty_ldisc *ld;
+
 =09int retval =3D tty_check_change(tty);
 =09if (retval)
 =09=09return retval;
--
2.39.2



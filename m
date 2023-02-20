Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFD969CFC2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjBTOzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjBTOzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:55:39 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B20D1DBB5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:55:38 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id o4so1507897wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oAZAYf8IkA6z8IsyIbMwvqk9tnk/HNehC8AeMKaRspI=;
        b=I7zh6D0eZxMd8FZdUAA/qHau87amWxBz+0hXjMkoCvEpRbGllw7OaOh73OfG4pO1IV
         QB9iC+BhWIMXsZd3L+ccr/My2wFZ6qFHmFKhDrKfUFXhE6Mkp+FVDrzQ/GFMy8vqfEVp
         5KUD48kRw0M9/eRjQY+y0WDfAx1bJtOjcJwG9ZKUTLbkNlNWH32bpn9ZHl8UgK4t8Skn
         //ODqUrKHl/USGicTldSaayI02q1E9iePAAf5WGK9XmJFdYu3fiSGYoB8NJw20OOqUf8
         XgAy92uSbMMWI1YlYGgM1dmdGCSwN+K7R7VAvHLY+vLZV+6UO70eN2m4zgJhIzzs9OTT
         jHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAZAYf8IkA6z8IsyIbMwvqk9tnk/HNehC8AeMKaRspI=;
        b=d+UFAj3XuL9ZufX3RNviml1Kq4V+hv5xc+AV06WSlGjRDQWJ43aiQjJ6iBByrvI5ld
         s+5aK6noMbU1hp52LtcMr+OUtev6XHfCqn7W5fzz4ihxI5hBRnQvEnxRdabxDDSdCY0y
         4BEtYTg5ou0e5Yq0+srugT2nqtshZS8/1AXePwORjiMNYv0GAKJucJbtEV8RLqJpBw1Q
         3ClSBKhgmeP7KsA0zV0Y7VEi2hk1iXTIiIPnNtX624lF6znDmrp94dUe2g7Mqq2PhA1M
         mrhnTc10DNGoeTbRjsiMPIhnFBgc3Wez2Qwg/PoHKxuLsEGiFtTZVJeWhDhpcEFQDIrq
         Z8Og==
X-Gm-Message-State: AO0yUKU9xRKtSfvo0PNll3bi+NOtoQdRsYKO2SD3s5ZPJgXm3DTo+pci
        QKzBC9G+BrnOwFb6jkWw++BpcxjYKybNzQ/vB8s=
X-Google-Smtp-Source: AK7set9dGHZJRelP4kxDqLb+C9HgOQyXJ1a0dGZl3guv29VzoFfqN0yCc6beZJN4QoNF7IbWBiPDw6TW4JPv1dkUgwc=
X-Received: by 2002:adf:e84a:0:b0:2c6:9465:732a with SMTP id
 d10-20020adfe84a000000b002c69465732amr181419wrn.726.1676904936557; Mon, 20
 Feb 2023 06:55:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6020:7b48:b0:259:c75b:dbe9 with HTTP; Mon, 20 Feb 2023
 06:55:36 -0800 (PST)
Reply-To: georgebrown00006@gmail.com
From:   george brown <morganalc65@gmail.com>
Date:   Mon, 20 Feb 2023 15:55:36 +0100
Message-ID: <CADVM_kc-rVcgmrZpz-FfmTv8UrrbmL0iYBdGwAZS932P=z8Zuw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:443 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [georgebrown00006[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [morganalc65[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [morganalc65[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo

Mijn naam is George Brown. Ik ben advocaat van beroep. Ik wil je aanbieden
de nabestaanden van mijn cli=C3=ABnt. U erft de som van ($ 8,5 miljoen)
dollars die mijn cli=C3=ABnt voor zijn dood op de bank heeft achtergelaten.

Mijn cli=C3=ABnt is een burger van uw land die samen met zijn vrouw omkwam
bij een auto-ongeluk
en enige zoon. Ik heb recht op 50% van het totale fonds en 50%
wees voor jou.
Neem hier contact op met mijn priv=C3=A9-e-mailadres voor meer informatie:
georgebrown00006@gmail.com

Bij voorbaat hartelijk dank,
Meneer George Brown,

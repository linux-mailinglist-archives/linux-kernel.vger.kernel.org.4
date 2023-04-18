Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E445C6E5DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjDRJkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjDRJkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:40:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2107C7D84;
        Tue, 18 Apr 2023 02:39:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f0a00a5880so14036885e9.0;
        Tue, 18 Apr 2023 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681810797; x=1684402797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzQBmhBycWm3Z62ZlfZCa618OpeoVEJ5/aiYxN8jq8g=;
        b=Y8X8UNZ3w6OP7zNvJtK8S//kpaupljHwfXHt1s4mtjajbW+xW7UhtBZ06YIMp2AAu8
         cq9xxNTjCkt7qUgqteV4MJ54oxoAbc7Tw82xsj5RIRtAbbEDygewA5bcaopcldsde0Ov
         LcEpUgVX6qf2/5Iq0q7bHGRtzsN3EBDdgH+jzCMfm6MaSeQljGUIxoPREBkehDCdSMFT
         fnHFsBDaw4lPYCU5ljyfN9q+DeRO3osc7bhUUM1eh6q/FMKY8e68Wsp8NV+cd9ykRC22
         736BNbfhsW8wwYJ1Jls/UqzT+xI0UJjA7bvliZwnmfSI/Nh4Qcmfr7wpKBtgiXr6IthU
         EzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681810797; x=1684402797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzQBmhBycWm3Z62ZlfZCa618OpeoVEJ5/aiYxN8jq8g=;
        b=lFG03HGy2BBXErV3uFHBGB3ECcncp48biwiVdGmB6S8NS3JrdylL/1CuVhbLJ5I0BE
         ErQjIjRN5TNTBEWklxmK4GgB5dExmZEFWKCniys/Lj8XJ9VrURy1XiS9jDDh25YrvwT2
         rNl2DTSmb73vinbPjaz5QEnpdnrknrt3w6J3kC1atvZWGkMMyrspopmKswYr8Kwch4ZJ
         NzMmKKelF/dlL9LsIN3dcrk0PB1XPb9RRbVCskT96OnCow1Kt1AIsF4cO1i94Ozv6BSU
         z+7IouMTk9oixAVtu8hN7YD37zhtPzXNMoaLCteGODKLBKHlIfyUKJkdBBe6Cngw8rBT
         JCwg==
X-Gm-Message-State: AAQBX9c+haF+PbpLxOi2AErFrhwOecBQQhkwj+r9GwSwgMuFFpLFd7l8
        ohlVJy3zno171JzwuR37Mwo=
X-Google-Smtp-Source: AKy350ZQeQOBzR2NxmiWEuG7qicyB6tgVhfnjd7tiafeRzyIisX1X4roYNyApYsHl9lPDW+mjo0PuA==
X-Received: by 2002:adf:ea8b:0:b0:2f2:c46b:1eb5 with SMTP id s11-20020adfea8b000000b002f2c46b1eb5mr1491650wrm.59.1681810797486;
        Tue, 18 Apr 2023 02:39:57 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m14-20020a056000008e00b002c71b4d476asm12576888wrx.106.2023.04.18.02.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:39:56 -0700 (PDT)
Date:   Tue, 18 Apr 2023 12:39:43 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RESEND] sh: sq: Use the bitmap API when applicable
Message-ID: <837e9f5e-ca8d-4c93-9a89-d7bdb9bb0240@kili.mountain>
References: <071e9f32c19a007f4922903282c9121898641400.1681671848.git.christophe.jaillet@wanadoo.fr>
 <b5fea49d68e1e2a702b0050f73582526e205cfa2.camel@physik.fu-berlin.de>
 <14788dbc-c2a6-4d1d-8ae3-1be53b0daf17@kili.mountain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="V2iJ7csRRNqcDySa"
Content-Disposition: inline
In-Reply-To: <14788dbc-c2a6-4d1d-8ae3-1be53b0daf17@kili.mountain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V2iJ7csRRNqcDySa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 18, 2023 at 10:30:01AM +0300, Dan Carpenter wrote:
> I have some unpublished Smatch stuff which tries to track "variable x
> is in terms of bit units or byte units etc."  I will try to make a
> static checker rule for this.

Attached.  It prints a warning like this:

drivers/net/ethernet/broadcom/cnic.c:667 cnic_init_id_tbl() warn: allocating units of longs instead of bytes 'test_var'

I'll test it out tonight.

regards,
dan carpenter

--V2iJ7csRRNqcDySa
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_allocating_longs.c"

/*
 * Copyright 2023 Linaro Ltd.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_slist.h"

static int my_id;

static void match_allocation(struct expression *expr,
			     const char *name, struct symbol *sym,
			     struct allocation_info *info)
{
	struct smatch_state *units;
	char *str;

	units = get_units(info->total_size);
	if (!units || strcmp(units->name, "longs") != 0)
		return;

	str = expr_to_str(info->total_size);
	sm_warning("allocating units of longs instead of bytes '%s'", str);
	free_string(str);
}

void check_allocating_longs(int id)
{
	my_id = id;

	add_allocation_hook(&match_allocation);
}

--V2iJ7csRRNqcDySa--

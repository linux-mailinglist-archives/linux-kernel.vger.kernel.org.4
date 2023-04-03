Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFF16D4002
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjDCJRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjDCJQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:16:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F01610AA7;
        Mon,  3 Apr 2023 02:16:22 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ek18so114543056edb.6;
        Mon, 03 Apr 2023 02:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680513380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=31Wjg/LmLDHA4briEYR2A/3JNw0vmPfLkG9fx2QUjyI=;
        b=kDStKDmVvvOJM0bR2+MjBZfieu+sJCY9LuX5WxONmwMWwl11Xvezp6WJz4AarJ70AR
         Hg5CN1+Boj5zbvBxTUdY+IB4HxN/EdzD1g5IfJY1kwXggYdsFENN1My2Zfp5YRl7WRJm
         xjdNHTvg2nlnMsXolxGzNnXYaaras35U4ftc1ADoG9ALq5O3O16hFveCVojGFR/FPlMr
         uY542Sx4JlmjI5fAeRb42ZMI3BKKzLB0Tx1OJi2tnIsbp1Rc8s/UNZmkVUW1NBGSkXFg
         3mNcXkR0iMQft2rGviDuYhleFPbzqbFV+sUNM/z3ERRaiEjjDYUItX1wbnwKNpmf8Hn7
         PN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680513380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31Wjg/LmLDHA4briEYR2A/3JNw0vmPfLkG9fx2QUjyI=;
        b=6KM7r3uICYi61aTE6wVO++68W//HKI08ZF+AQNNG8qTgZIyPt7XrGsHMwWX/vSgt6y
         PSnctWXq9QT07ynGVnriEQgmOP5Ev93ZDv65HJleEUrBfHfTBgoyJc3RQ0lMucLEt2U+
         E1d0hXBCR5noGdcIOYAANVsmxol7YRYbjHTFB7MsfXFHKfc1ZauLhvr3tueikQ4j/y5b
         6L5EUShuntrfL1grVwA6cX6LyVrTjfRH4TsrmhOApIQmqNiNW4b7WGTaMflP9KQBw9SD
         5FUisLuij9M1mcQmYDHMp3+ZdUGQNhoMGeKuTKuDa7agPZ83JRihhLVfLocUze9WxjLz
         /M9Q==
X-Gm-Message-State: AAQBX9elzUJjhNvKW1Ip+1WDV9Dg8125B7ban9AgerbbU0tqAjsTr3rD
        pK4qE+TYxQptFVzwpbrlTS8=
X-Google-Smtp-Source: AKy350atfEBSrTVKgqBuIzdw/UZRkrKjNrMECkvSgQSsxy/WN1nOkFWrkUvddMqWLQpH1JG8HW51WQ==
X-Received: by 2002:a17:906:a887:b0:939:e7d6:7c52 with SMTP id ha7-20020a170906a88700b00939e7d67c52mr33738486ejb.20.1680513380242;
        Mon, 03 Apr 2023 02:16:20 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l22-20020a1709061c5600b00927f6c799e6sm4243650ejg.132.2023.04.03.02.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 02:16:19 -0700 (PDT)
Date:   Mon, 3 Apr 2023 12:16:16 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     lishuchang@hust.edu.cn
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: fix ioremap issues in
 'lpfc_sli4_pci_mem_setup'
Message-ID: <6df77fb0-6b3d-4e3b-9c5a-40e217e8dae9@kili.mountain>
References: <20230403074821.5121-1-lishuchang@hust.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0l+vRQSv3t7ooNLn"
Content-Disposition: inline
In-Reply-To: <20230403074821.5121-1-lishuchang@hust.edu.cn>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0l+vRQSv3t7ooNLn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 03, 2023 at 03:48:21PM +0800, lishuchang@hust.edu.cn wrote:
> @@ -12069,9 +12069,11 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
>  	return 0;
>  
>  out_iounmap_all:
> -	iounmap(phba->sli4_hba.drbl_regs_memmap_p);
> +	if (!phba->sli4_hba.drbl_regs_memmap_p)
> +		iounmap(phba->sli4_hba.drbl_regs_memmap_p);

The test is reversed still.

If you make a mistake, you should write a static checker warning so that
you never make the same mistake again.  ;)  See attached.


>  out_iounmap_ctrl:
> -	iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
> +	if (!phba->sli4_hba.ctrl_regs_memmap_p)

Also reversed.

> +		iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
>  out_iounmap_conf:
>  	iounmap(phba->sli4_hba.conf_regs_memmap_p);

regards,
dan carpenter



--0l+vRQSv3t7ooNLn
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_passing_possible_null.c"

/*
 * Copyright (C) 2023 Oracle.
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

static void check_non_null(struct expression *expr, const char *name, struct symbol *sym, void *data)
{
	struct sm_state *sm, *tmp;
	sval_t sval;

	sm = get_sm_state(SMATCH_EXTRA, name, sym);
	if (!sm)
		return;

	FOR_EACH_PTR(sm->possible, tmp) {
		if (!estate_get_single_value(tmp->state, &sval) ||
		    sval.value != 0)
			continue;
		sm_warning("'%s' potentially NULL", name);
		return;
	} END_FOR_EACH_PTR(tmp);
}

void check_passing_possible_null(int id)
{
	my_id = id;

	add_function_param_key_hook_early("iounmap", &check_non_null, 0, "$", NULL);
}

--0l+vRQSv3t7ooNLn--

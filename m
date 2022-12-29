Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0494658928
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 04:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiL2D3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 22:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2D3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 22:29:17 -0500
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA213D5B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 19:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1672284551;
        bh=UU93fVlYjXrZmVWksMFApIIJgL0Los+nXQrfTOSsnqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=USTRqQJIvBWag56dfvGXd7+yZo9IT/Sqr+QxWzGiwnJDaBN9Aa1zIxAceiyBqC4hw
         hB604hQjCGQHT2MjCQuY/YtFjeYoEatmVBWcOV4r78j+3bMKIK5TDRmzhAkemPfOrD
         u0nAcXD2hjKy9x57eJ0m8ZXNaR/QpTMjIyq+7r+k=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 748B90E2; Thu, 29 Dec 2022 11:29:08 +0800
X-QQ-mid: xmsmtpt1672284548txjyko01l
Message-ID: <tencent_61428759F197532A46AF38A338882C06D108@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujsNeHzHJsGOWF7i+VEDPfUmy0rnDT/lSrDpdRbZLQJkKyekst2Z
         JHPOYze6dwXkVG9RSVbaGW7iZ9BuXqYlCttAa8Nmno0D6YZaw6oeD699SnkBrkAKR0hwf1cvz3FT
         4HYh5mDaj8deh7Y+8bfI8kkiMQFVsn/lsrY35lZJ3C4gfrExMLrSFxYUrAjjKKW72VqxGdV/T+Q6
         5adfp3dwXXlTk38Gguu3oFcDMVF+/MLpvz4tpH5qt1lZysncnsFYsC6OCeJ4CK1GxkDe95Zo15qY
         6lYRdSJ27doLUTFH1cChLgyVjeld1r0SrtRHzJ18ea42WbcVzqLNnTUqldYOYPC90GwWNO281etZ
         oUxMbWVhRRQEl9fwiwNNNbF1tkD0NVzgmZfh15ScDD6hMNyw7QsKzqeCPqySjqSmEHG8Hx7HI9IJ
         gtNQ+simxzB04JVZiUuEQ9yUKbq2KuHI77Zg3Gc/DF1+whEnhGwXt2q78ruTHlPqg/rxWk+Ct+lv
         tSxRDhb5vzTBU4Gy4Z7az/l69zD6L75eIAHrFzqmIqgql2SxtnSehCz6feVDggh3Dne/3zrBqIZv
         jl0t7EjyAq2Ngta1pvZXMOwljDizpciJFd32ruD7lmnyzpfUX9FTliLbZc6GWKh8zI5C+lg+gQ2C
         d6hl+wkSr64a49X5UtCYW/tBQ4BEVnwHX0aRDQelVCofTYz0wt+Zum6/cMNKqn6fsYCFjgvyZ4bl
         1NKEKHZfVlX3D2Ptz4n9o2nGEcNliXHo8kSPHS0aoHcTWS4u/iwnrla45v33PRwPFbzu9EH804g/
         TjFz0s7mGTodr4I2GLPOZc2Q+HD0ubq5owCxcvtXWXPhLr8psc8h5sd/4jF5Zb/4BePe+GoJ3dTR
         afinZn+4dE5jzpB1l0qx5QqOO2lcBa0J14gLL3iIuUTNBLZXxlq2lzmAEypXvfw9CbBbov3tSlg8
         mXfspH2Q9FPHogNBpUWTPxz9DdLVAlqtAGbUydtjVbVDIaF50QE3u2cllupbPY792i1Nv8VM0=
From:   Rong Tao <rtoax@foxmail.com>
To:     thomas@t-8ch.de
Cc:     jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        linux@weissschuh.net, peterz@infradead.org, rtoax@foxmail.com,
        Rong Tao <rongtao@cestc.cn>
Subject: Re: [PATCH v2 5/8] objtool: reduce memory usage of struct reloc
Date:   Thu, 29 Dec 2022 11:29:07 +0800
X-OQ-MSGID: <20221229032907.8435-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229022622.khboqwfe23e7u2en@snowball.t-8ch.de>
References: <20221229022622.khboqwfe23e7u2en@snowball.t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas:

In /usr/include/elf.h has:

#define ELF32_R_TYPE(val)		((val) & 0xff)
#define ELF64_R_TYPE(i)			((i) & 0xffffffff)
                                       ^^^^^^^^^^

So, I still feel that keeping 'unsigned int' is a good option. Can we just
use __attribute__((packed)) for wasted padding bytes?

Reviewed-by: Rong Tao <rongtao@cestc.cn>


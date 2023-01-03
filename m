Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7A965C335
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbjACPmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjACPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:42:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB1211C02
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:42:00 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672760519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yp/G7DXK1fTH2v7v0HnOT9IESWacMUXk7lsz2N7AjCk=;
        b=hGc9mi3xFY7srKxqzhtWDuojPxwnYPXr0y0uEDMJFZr+r/J0XqkdzN2Vl683J/QIAVWL6r
        vBcXdsAFA38crsTGiw5o7APSEUDvJaSzX3cehN+xJt0UZ0w8xP53Kz/7prrpqQUJUjakEb
        jclJdx1w6iSurMaUigmpfLiYxjowlMO4EBgfyf+9z+apXLcU3gppmeR6abV5HQcUXm3Zzu
        MVkkmBZhGz3rEsyaUpXilaNuuWTOzcALaahR9oHs7AtR8TuYiR2HETU+Ed6rAFdpyU9HOr
        2R3vCRGrprGOL9yyEGfyVPIS7tPuiP+jY2Rz2ALP2pBw/bmQ0xAuecFJzqcyKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672760519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yp/G7DXK1fTH2v7v0HnOT9IESWacMUXk7lsz2N7AjCk=;
        b=ZC6ch2Seh1aJK3FGSZdNP1YccPxH10iPXMeYEP3g/kk7ox8JmZ585byQnf/PKG5xOwIH7B
        37YNPUf/ek9EBfCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 5/6] printk: introduce
 console_get_next_message() and console_message
In-Reply-To: <Y7L9pdSo9fSmx/F5@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-6-john.ogness@linutronix.de>
 <Y7L9pdSo9fSmx/F5@alley>
Date:   Tue, 03 Jan 2023 16:47:21 +0106
Message-ID: <877cy3d3ry.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-02, Petr Mladek <pmladek@suse.com> wrote:
>>  	if (is_extended) {
>>  		len = info_print_ext_header(outbuf, outbuf_sz, r.info);
>>  		len += msg_print_ext_body(outbuf + len, outbuf_sz - len,
>> -					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
>> +					  r.text_buf, r.info->text_len, &r.info->dev_info);
>
> This probably was not intended.

Actually it was. But such a style change is not appropriate here. Sorry
for trying to slip it in.

John

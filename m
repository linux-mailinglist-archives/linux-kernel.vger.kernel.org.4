Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8D2629171
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 06:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiKOFVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 00:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiKOFU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 00:20:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F235167DF;
        Mon, 14 Nov 2022 21:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668489641; bh=7a1CDBFiXBSPRVqpkBP3B5ID6/eFzYXsb4HHp3hy4ZI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=g0LO7Z1VURvA1WeG5jNOwHCP+j2llwjGhcV37ASuv9hbDxY8YfnftJ/A7J8pVmOJ+
         Q2/qfBKUrqDbthJ/XOP3lKT6Ig00Vmsc2G/zJozNOKo0iWLslgNOWspAO8K2CzOLcQ
         hcABdSoWHPvhr3m9YF5eSWrDJCwZX7MakRJbgRQuRLt3rkHkp0T00vpdPmCmRZeJwH
         e6eBcZDWyYNburnF2AnNyJaPOfL1ulvmY9HifuxTCQbwyizH6o8inoiZSVkAjTo3Di
         s5YBdCeo6UOOY66bbUbuFsOjIRCJPm5qXmv9kasXtC/S3i/n1li5SoyeTZi2Heq6GZ
         EafXh4r5nzPxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.131.87]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVNAr-1oUjCY06UB-00SKp6; Tue, 15
 Nov 2022 06:20:41 +0100
Message-ID: <17d44085-ae13-44ad-f9ac-031931ba26df@gmx.de>
Date:   Tue, 15 Nov 2022 06:20:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: linux-next: build warning after merge of the fbdev tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shang XiaoJing <shangxiaojing@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221115112021.1c8aa004@canb.auug.org.au>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221115112021.1c8aa004@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hke/3atF54baUqnxwwJbD2mthx5HOzSEbbYRDm8Ed2sJmGBQ68z
 zI8Lo2wng3uFZ3BvwLSOmMrb6pXVXVjGPmx9vDSSZt+LZekfOe8POjEIJ9iX8BXWvExAtUN
 1fZCBFBq2ro7uCcwNznEJSuIcHwcySGvi3wgxN7xpKtFv79zNxjVAS7MVLkevPyTT+TCNGT
 WGfWgZtyuMEmOZHRGr80A==
UI-OutboundReport: notjunk:1;M01:P0:8Li9gYSNWb4=;AzoWVn+jUfqgCUAIhkLssVxKdKW
 885tT90t09WuOvDHe2wmzmPiqrwPp0Y6xQiIEK6EMz4VKykHCnMQJ6A+j4JcxovQo83MS8kRh
 bsM0yiFJYt9zoMLwBjV1JulyoPIw8RLw/hwZPw7JATQySccXC80hfTdTCs9KhorIzT4Lf/rUE
 DH4YTueGEG1dtDFKeKUsBu9N81u/Wm6JcgNMWXcx/DPxGRv16tBqWXDGU4iIdZzIjDpTuD6nA
 VzdUGryStAHumPD1Ym5yA0ueO/A94n33ZA6FadmTy5LHeHMSs1gT2NmhwGdHl2OEsH1PAc2cX
 44AeLy/7ft0g9VHDkm/4WspmIqyflshmgtZRCZnSqDjt7D468ZSdc73MSl1ZhYE6P3Y3+lOYu
 X9cMpG38EGXX/EDbRUqi8IAA2BAbtMMHJacQsaDksAdmmsx60PD2GVW46hEHtgAzJk8FY5bHn
 umC4wNkFOWCRq+vZzFH+XtLfCE3l7hqDkZpY7hmUWrSYVcG/mgbgMQNkqK/o5pYCIvUds4xxY
 1m28pp71pp/3y5TAuW7r1E2B0EkLbDwwvTv6J+kBtUxgp9a2RUVkdJGoUQKuwRHlJgrXaIpsq
 MAAmfSZMR9GCaXk3mIu3YAhZoGtqBTcubwlIaooKhh10C9xpVKtvdzrtReW6z42+3m5AqkIqb
 oAIPSORdvLKvFFlgFYfi7ZLsX8g4l7gn+4/PckxpxRKBfCmPqAvOixCcNZwbK3Al7r6VYzZC8
 Mr/Vk/7xafrrzCZbfwp1QV8PdYx/MglMDGlBfUYxmwnCYNS3uTD6v74poMa6zIKfRBU4Be4FC
 6tUf+VxyHKnC0WRwUYWTFCf3yaHsh+SvZpL/3VT7yCLvBxcKhtAvwdoyVbnh4jz2ffPtcowtI
 yzWDE1vrm81JQluEFlwuduvlTgOu8f51C4Giy772ag6cliN/DnDFsE3cpglRJVBEQM2YcKg0v
 QY1gSoZulkKEY1XDQ3sw+v/6sJo=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/22 01:20, Stephen Rothwell wrote:
> After merging the fbdev tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> WARNING: modpost: drivers/video/fbdev/via/viafb.o: section mismatch in r=
eference: init_module (section: .init.text) -> viafb_exit (section: .exit.=
text)
>
> Introduced by commit
>
>    ab885d8c7e15 ("fbdev: via: Fix error in via_core_init()")

build is fixed for now... but still looking for a better solution.

Helge


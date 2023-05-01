Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96966F3161
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 15:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjEANDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 09:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjEANDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 09:03:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4EF18E;
        Mon,  1 May 2023 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682946226; i=rwarsow@gmx.de;
        bh=27FP0cCiehVy8hLWLcH6XQvkDYxeiixIs7dZCX/Qovg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=Hy8LyqC0edXx99qbJ+6RdD2F/846q8PDzqpJuXnOGraCsgtHU2D+KIqeABMSIpU+0
         jhFV5U7iHDJXvYxiC/SPD8l1z0l4czw8hj/lsasBuI7aEkG+1wvLFCNQPWxkSSZeiR
         5PDfCfvq0lpkBmx44CcgEO8aAH7wRH4ouTU0HZxYAPZIC72/wDgKXmROz4UHyCi+Yf
         rSO7Age/8NC04ReYa40252b/AyWkpZK6qfTvD46FU4JtOb7lTXSminhEBh/QAdA//7
         awtVLKgcMfHIvhMeL9fLQel6cRauHNSQcIt83FPBOpyFNjQfsQMDdEtOSHqsKn+vt+
         OPMGc2kXyxJ7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.231]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95eJ-1qMEJ30PR9-0168J6; Mon, 01
 May 2023 15:03:46 +0200
Message-ID: <f0497747-2318-7355-6ea6-ff01f9eb97ef@gmx.de>
Date:   Mon, 1 May 2023 15:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: Linux 6.3.1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UDaDsvLNzvyy5oTZ+O1q2DKTdpWveNIHQwPIpgpeZhW+d++W615
 BZ6BgaKpvLQL3DRrnDsyRnKrBgkpwQHWvJS+nApC8DUhpjixaWhH7aY9oqRK2IcBeTjvRsG
 6ggZ5WYigw3yNhiYMCWuKPx2MzHIazCnlFrbDrmkGfgVN6oGr68OkxzYVH1bdtB+qkPcF0+
 pCrQJSyxwCkEynz9vSdcQ==
UI-OutboundReport: notjunk:1;M01:P0:wRZDy5XAjB4=;ZwAAUoCaA7Ioj87pje3+XBwB1Iv
 x10ucoroP2FqS/+yqzamnKpe2vy7iwkCBkwcfF2+E+fAD+8VN9Q/J0Fz6Z2LUX7RTIO09+AbN
 WvO9lS5yMcnB0bKgbHPGfWKCVoLlXh2g5XhQQjYQgdkKtxCQXg3hIOVkHi/FtVbnwyErKSAXF
 WodESyEuvzIuY6brdj+Bl8p1RNfc5pLkzcHWqQD8Y5wWOy0eAtev/2hn6ugp7C4A0wdxn4i/b
 fkF1m0ld0fobDEYB4CDb4KCQIAuTRQly6kAfYtr/r2UioRQk+VjhmATrorchLQrRQY5Z7izNB
 zO6WjxnzhOXpfzilsfzTnz8f6eeC14u0TedMLBnwXdf8QimnX3tkOobiWDVDiOO18WCxFa4Um
 Zlw7XJEM9UnsYJuGqjo+7PAMGIjdADgFMJ1m328JPmifiCvViyIWQpWCIu3kQE/n5jU1SVB48
 7qlTb9R2G8I+ixSWnUA8ecwk81v1LUwt94DEvhfkm/KsTIu64h9jyytSSvUtaAlBV71A27WUl
 PFIGDtGJY8IcAlktxy7WoqaXcCzDz8b/rpvhyjauIyuh3u3f21fH8bd1NCHCecnG+NSjYA9FA
 GmUyfExKxxG3YvYDlBTaM7lLwAaLi6qmdKRVCGEPYWrHcGz7wb3oMJrUbJDUu/wLuwJ8uakzP
 +706iMA5djwzYMFREmhL42V0ytjETqOXSyxLAUr1PRZ6bBcUtRcxJhRIwiSTQpN5cJFV6/bMo
 Us7WUX1RGp2IwGvTpt0Oi/JTKtT9K8ZpfA4vnAH9pKbO4kPuXpvLQC4GK22IbWk40LwCrrmFu
 +zFVEtL1O9sPckKEEvD0BHDxMoljCceFk6wYn60XjWVLcLZaSlGYg1lM7L0qiK3nm7FpfxA7m
 njIGZKU2YLNGkI+BAlrngVYZefo5jQ/q217iHGIIZyB3XUX2bFPHU5yt1T4zWHLY6/AWBfnx5
 uCL63EOE/pyhwQvMfhAwBT3+jDA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

fetching new kernels via script:

https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/get-verified-tarball

it seems
https://cdn.kernel.org/pub/linux/kernel/v6.x/sha256sums.asc

doesn't contain a hash for 6.3.1


Ronald Warsow


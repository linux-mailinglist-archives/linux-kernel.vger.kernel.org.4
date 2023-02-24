Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445B66A20AD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBXRqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBXRqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:46:54 -0500
Received: from libero.it (smtp-34-i2.italiaonline.it [213.209.12.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5646C1B3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:46:51 -0800 (PST)
Received: from [192.168.1.176] ([87.6.129.129])
        by smtp-34.iol.local with ESMTPA
        id Vc9ipVlFgVfPJVc9ipbuLa; Fri, 24 Feb 2023 18:46:50 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1677260810; bh=Ejabf+Fi8cuY7wUHUo2cWIYILAeQJIhe3muthr7cnVs=;
        h=From;
        b=R9j93aI7sqb8fmEVZxbpmSlzN6AiJCMwQcy7b/ssoED5sO7MLMfUn6hYkDwCdLUpE
         TJh1bTQbI6WL93b9cpOx9ZCiuPvKShAbwH4V7BCvEkZSPxBRliuG5FxjIWOKgm6S/Y
         t47hWJsomF5hyRBIu+RQ4/s6ln1Fy3NJ++NKx4lFoYUR12rf/E/7ocnmTqQk4Fvdo5
         0XhlRPC7eMCZNVcjx/LVhb1BmiuLzhE/5zyLSQ/51V6KrOEcCDvjqfgdpMsgaBgsOd
         zdy285Do/pPZU7U0M9LuS7m8y6Ya3RyP4flRmUYoMiDumnmjfrjceg/AuT2c4+GJdh
         eY2VP195gAMmg==
X-CNFS-Analysis: v=2.4 cv=EKfAkXVC c=1 sm=1 tr=0 ts=63f8f80a cx=a_exe
 a=ZxqhrVAgG8YdQk3VCnDUFw==:117 a=ZxqhrVAgG8YdQk3VCnDUFw==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=pcNOOGWl7m_sQj1MCncA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <87f7b3f4-8586-4c10-d4f4-643ff5f0cf62@inwind.it>
Date:   Fri, 24 Feb 2023 18:46:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Valerio Vanni <valerio.vanni@inwind.it>
Subject: Kernel panic - not syncing: Attempted to kill init!
 exitcode=0x00007f00
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: AVG (VPS 230224-4, 24/2/2023), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4xfK6oPIsHVx/hNNAui8o++f3i7OTQjIlEsIZeiBM3AaRJGIYzrg1VZiuBVYo47CGcmYf2UHVX8xGUQrS8qInYq8YVgJpgthbCHkhCVyAIFkRRZ7j10o8a
 hVW728UbTGpREsv7OZcQJqzmDJ7B+8SgXZUVC2dqC6DewvuwVDZ5ODmAe64yYBkaKTlyuTRPHmcULomQJ+yUIiBrEXEfQkiXCYA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=217083

I got this error after upgrading a Debian machine (x86-64) from Stretch 
to Buster. Upgrade is successful, but the next boot it crashes.

The machine is an Asus B360M-A with an Intel i7-8700 CPU and 16GB DDR4.
My kernel is 4.20.17 (from kernel.org, not a distribution kernel), but I 
tried with 4.19.273 and 5.10.169 with the same .config.

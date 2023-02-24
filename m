Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5E6A2081
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBXRbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBXRbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:31:34 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Feb 2023 09:31:30 PST
Received: from libero.it (smtp-34-i2.italiaonline.it [213.209.12.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F904E5C3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:31:30 -0800 (PST)
Received: from [192.168.1.176] ([87.6.129.129])
        by smtp-34.iol.local with ESMTPA
        id VbtrpVeG7VfPJVbtrpbpQn; Fri, 24 Feb 2023 18:30:27 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1677259827; bh=sVgZMa7XGNbF8bO6/51EavTN1f497YDnLUjEWguDYS8=;
        h=From;
        b=ioNuZLZHY1QkUQr3qOpOGxpcOn9zkLnEN1zgxzobMUkP2LcwnI2oVl5imhJNKsUzO
         SgnEnZvBuj/B7lWTr+AiZgGJe5x9kOu4wf6SpOdFN/6NddJRKJMJmy0/X6BCqOn9PJ
         Y8Uor7HsD8XWyQK9Mx7MptbwShT4nMorf7u/WKylh3m8grdLnxwd+7iNywjpd3mwWS
         C3h359eVK+41Lr5WT3zXXkxZWJ060f6mFIRonohNxfECb0L7a+IWXRXog1mqbaRbjJ
         fE+nZ3VzJo2fZ2J1plYaC0f4Hi6Rbbptcz0XNdPdn2iObRZdGi2zcWYpZrhtkPZWdG
         Qc2b9fyIBcFrQ==
X-CNFS-Analysis: v=2.4 cv=EKfAkXVC c=1 sm=1 tr=0 ts=63f8f433 cx=a_exe
 a=ZxqhrVAgG8YdQk3VCnDUFw==:117 a=ZxqhrVAgG8YdQk3VCnDUFw==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=CpviIb0-6JBOsNwm3AgA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <f4d6ddad-90c7-8a59-4f1f-334ae5e38463@inwind.it>
Date:   Fri, 24 Feb 2023 18:30:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     linux-kernel@vger.kernel.org
From:   Valerio Vanni <valerio.vanni@inwind.it>
Subject: Bugzilla 217083
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: AVG (VPS 230224-4, 24/2/2023), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4xfDIsVw3BgJk7kYYpgOlpkKbCjfeV24J42pGXSO4jfX1gfskWg0T8FQIQBmz3oWXMgurOECXNKht7qArb0OAOTeeCfNBq2MhQljK78CgPT180ASAJRlAY
 ds31h9Ms9/5nQBlUvxGmqA5nRRT4AZPCyK6QdsHbRRXE4+5SMgUx2cuxJ9NXCBjP5RUwphw6mJYdg7fexGO9O+b6K3PKxJtGgZg=
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TVD_SPACE_RATIO
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=217083

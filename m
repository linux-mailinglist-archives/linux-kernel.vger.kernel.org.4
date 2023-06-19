Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA7734B80
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjFSGE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFSGE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:04:26 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D56583;
        Sun, 18 Jun 2023 23:04:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 0C6C86019E;
        Mon, 19 Jun 2023 08:04:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1687154661; bh=lcUEwvKHK/l3w8XrZyVJ+ORIPhjtF1cO4oSiOEidZBU=;
        h=Date:To:Cc:From:Subject:From;
        b=dj7GFA5gwtVHTf9DdsJRmF7ne5pi6S459/2Rj0Dk/2lec0vI7dpXlFPagjIcEGmVA
         mY7dw2KCVruzLZZ6z3BY0V0mQgBVuCX/DhCuxdsSMR5WD2N7E9H9znrnVvEbb+RNu6
         smJ6i+82Q7QQBUfuPzIdFua8mvg9ojMQLrVVneVt7LPw7tGSejB1CzllWQNMydtdWq
         NaZ8yFaE4IxgphezV6rsy+42JhG9hAiLzyUA23jV9vsQC9yYjmNbpT0hcatNiuViBO
         serQtx/3bB4D0s+BRxNkeZA7avcdAZEA4GcuLrwZgITterjwkt+DfIW8o/1hRT+plM
         hRt0pE7l3KZzQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2OAE_F3fERkR; Mon, 19 Jun 2023 08:04:18 +0200 (CEST)
Received: from [10.0.2.76] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id E453F6019C;
        Mon, 19 Jun 2023 08:04:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1687154658; bh=lcUEwvKHK/l3w8XrZyVJ+ORIPhjtF1cO4oSiOEidZBU=;
        h=Date:To:Cc:From:Subject:From;
        b=HiSHzB457ln5+e3T0TK7htfDAn2KaBZKGDzSBlhRqeVRLvFCZaZQpfKa6eCmwk1OQ
         wmJn5eUERr7qDLU5SIl6T64/+LwpTlDpRUbCN+rG0Q3d7Ujd6/NjmD+THm5EkqHlRe
         ObFirPIGt2Xx4OVIfZArF9/MOxCq8GdHQXwSMC4KlMu5r9Qjk+aXSjGWFG+onbOoni
         5kYQVtvr++vbene9ccsI7ivX/91S7jygGY9bfFEMO61jaHtr41Ne7xHEjOrPyBjTPA
         k4WDnTnyKVUN/0r3ezQZZgYwkgSiDCkAQ9+EqnOuc0WV2Hqn7bVYyAXrm0xBY53W3y
         aw5DHWcNAYdGQ==
Message-ID: <643f6e7c-60f3-4667-ff5d-ee62985a99e7@alu.unizg.hr>
Date:   Mon, 19 Jun 2023 08:04:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US, hr
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Pinging the Ethernet address
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see some applications where it would be good to bypass the IP stack and ping directly
HW MAC address (i.e. in Wi-Fi scanner where IP address might not be available).

I understood that RARP support was removed from Linux kernel as early as in 2.x.

What would be the recommended way to ping a HW MAC address?

Thanks,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633A2712902
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbjEZO6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjEZO6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:58:47 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E79D8
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1685113120;
        bh=YevYWlOMrCE8MVbxPpymt3DSL9QuAaB/3N70/BR/kcA=;
        h=Date:From:Subject:To:From;
        b=K43Pwf9x7z7ykyBCgfquFJMfHuqCknmsogOCd5Jn1PFI1jRzrrwnYNlDejoDK7nEc
         4c8gHPYQQevsBwBCe9Zc3l/abZcl/yNZwrA+RPIQ02wSKn9zJJapkzQQpzG0Tf+S8p
         sOCMi6qwg0y+VO6ABZADSsGOuoGWgX98uohyP8qSSRzyft8951UbEmmbLXKhTZxdCd
         kcHHYDLelUQ7TKWzQ8d9WprEUIHfenkKOIpkXPR5VMAWWe4bu00LpzkRUSFKU0C4OU
         p61kNs4QAcaed0ULL84s/OYRYAQwV3YE+JDxskWXc4W9eC8QUvB8kzQ8JAbr2STprB
         NoomLesbIzeyQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QSSjX26V2z15kf;
        Fri, 26 May 2023 10:58:40 -0400 (EDT)
Message-ID: <9cee6e52-e476-4b93-cc25-5941a72275bd@efficios.com>
Date:   Fri, 26 May 2023 10:58:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Tracing Summit 2023 CFP and Registration (Sept. 17-18, 2023)
Content-Language: en-US
To:     lwn@lwn.net, tracecompass-dev@eclipse.org,
        tiwg@multicore-association.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxtools-dev@eclipse.org, diamon-discuss@linuxfoundation.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Registration for the 2023 Tracing Summit [0] is now open! This year,
the event is co-located with Open Source Summit Europe 2023 [1] and
will be held in Bilbao, Spain on the 17th and 18th of September, 2023.

There are several options for registration:
- In-person ($80.00 USD):
     - Add the Tracing Summit to your Open Source Summit Europe ticket [2]
     - Register solely for the Tracing Summit [3]
- Virtual (Free) [4]

Applicant speakers may register now, and accepted speakers will have
their ticket cost reimbursed.

----

The 2023 Tracing Summit is a two-day, single-track conference on the topic
of tracing. The event focuses on software and hardware tracing, gathering
developers and end-users of tracing and trace analysis tools. The main goal
of the Tracing Summit is to provide space for discussion between people of
the various areas that benefit from tracing, namely parallel, distributed
and/or real-time systems, as well as kernel development.

- Event dates: Sunday, September 17th - Monday, September 18th
- Location: Bilbao, Spain and virtually (co-located with Open Source Summit
   Europe)
- Registration cost:
     - In person: $80.00 USD (Free for speakers)
     - Virtual: Free
- Call for proposals link: [5]


The Tracing Summit Call for proposals is currently open! We are welcoming
30 minute presentations from both end users and developers, on topics such
as live tracing and monitoring, investigation workflow of real-time latency
issues, and more. Please refer to the CFP page [5] for a full list of topic
suggestions.

Important dates:
- Call for proposals close: Friday, June 16th, at 11:59PM EDT
- Call for proposals notifications: Friday, June 23rd
- Schedule announcement: Tuesday, June 27th
- Event dates: Sunday, September 17th - Monday, September 18th

To receive updates about the Tracing Summit, you may subscribe to the event's
mailing list [6].

Please send any questions about this conference to <info@tracingsummit.org>.

The 2023 Tracing Summit is sponsored by EfficiOS and organized by Erica Bugden
(EfficiOS), Olivier Dion (EfficiOS), and Mathieu Desnoyers (EfficiOS) on the
behalf of the Linux Foundation Diagnostic and Monitoring Workgroup [7].

Thanks,

Mathieu

[0]: https://tracingsummit.org
[1]: https://events.linuxfoundation.org/open-source-summit-europe/
[2]: https://events.linuxfoundation.org/open-source-summit-europe/features/co-located-events/#tracing-summit
[3]: https://cvent.me/Gn0nkR (In person)
[4]: https://cvent.me/xywylX (Virtual)
[5]: https://cfp.tracingsummit.org/ts2023/cfp
[6]: https://eepurl.com/goakfv
[7]: https://diamon.org/


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

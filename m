Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8A74EBBF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGKKdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGKKdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:33:14 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63811A2;
        Tue, 11 Jul 2023 03:33:13 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJAgA-0007xE-6H; Tue, 11 Jul 2023 12:33:10 +0200
Message-ID: <1ecb37cb-deee-0b58-755f-43d9b4c3f04b@leemhuis.info>
Date:   Tue, 11 Jul 2023 12:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US, de-DE
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1689008220.git.linux@leemhuis.info>
 <d30686781c47c83927e0a41f6a1167a679fa822c.1689008220.git.linux@leemhuis.info>
 <871qheiwj3.fsf@intel.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 1/3] docs: stable-kernel-rules: mention other
 usages for stable tag comments
In-Reply-To: <871qheiwj3.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689071593;21c2fd4c;
X-HE-SMSGID: 1qJAgA-0007xE-6H
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.23 12:15, Jani Nikula wrote:
> On Mon, 10 Jul 2023, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> [...]
>> +To delay pick up of patches submitted via :ref:`option_1`, use the following
>> +format:
>> +
>> +.. code-block:: none
>> +
>> +     Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
>> +
>> +For any other requests related to patches submitted via :ref:`option_1`, just
>> +add a note to the stable tag. This for example can be used to point out known
>> +problems:
>> +
>> +.. code-block:: none
>> +
>> +     Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for >= 6.3
>> +
> 
> To me, this seems like promoting *any* free text after the #, making it
> harder to parse in scripts.
> 
> Of course, I'm only ever producing this, and never consuming, so if the
> manual reading is fine for the stable developers, who am I to argue.

I had similar concerns, to which Greg replied: ```my "script" is me
reviewing each patch :)```

FWIW, that was here:
https://lore.kernel.org/all/2023061936-eatable-grumbling-f3c1@gregkh/

Ciao, Thorsten

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F275E5BB3F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 23:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIPVeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 17:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIPVej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 17:34:39 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F097513DF3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 14:34:35 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4MTnQb0KFWz9sQd;
        Fri, 16 Sep 2022 23:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dragonslave.de;
        s=MBO0001; t=1663364071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdXu+ZDOuqXStM4nU1Vz36p4CfWjMuPPU8DHgz4RUgA=;
        b=Rxs4AXROMrfMDnQ9SaiYBBkM/9pmJ3CJWUXi7JpP2sGsH1mkBrKu0rnbcwvV44/2LzVoE+
        JyQ4bmNkYgcbCL90yivU/HeAZMbKgzXoIO6di79/JryoVSUylp3iem9m3TkPDM3sRAhkdW
        ByRnK+fU/vdEYgS2wUIrBi/nkxVVGUw3qm8P19IS7Zw2rNPbdV0gYoZ9TOt5ahbe5El7Gv
        mR6H9DTIjp+b67fAleWp14qpkKkFJCFOSMurDX+Odg1cVArtKfhk/AWpFec8q7v9kD4LWt
        b5SdgIV2ZkW60/MGyzZ3DhRqiozIfo8Wcx+9DzGixZLIc7szctxfze5veuLalQ==
Message-ID: <9404d20b-1abc-78dc-d257-521c80f48b3a@dragonslave.de>
Date:   Fri, 16 Sep 2022 23:34:29 +0200
MIME-Version: 1.0
Subject: Re: Regression in v5.19-rc4 Sound Distortion
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <46fd7a73-06fd-a8a0-8530-0ecf9b18c08d@dragonslave.de>
Content-Language: en-US, de-DE
From:   Daniel Exner <dex@dragonslave.de>
In-Reply-To: <46fd7a73-06fd-a8a0-8530-0ecf9b18c08d@dragonslave.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4MTnQb0KFWz9sQd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Something in between 6.0.0-rc3 and 6.0.0-rc4 fixed this issue for me.

Greetings
Daniel
> Hi everyone,
> 
> 
> (please keep me CC as I am currently not subscribed to LKML)
> 
> 
> Since  v5.19-rc4 this box got some *loud* distorting sound on boot and 
> after some time without any sound if something plays sound again from 
> the integrated speakers in my monitor.
> 
> 
> I managed to bisect this down to:
> 
>> commit 202773260023b56e868d09d13d3a417028f1ff5b
>> Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Date:   Fri Jun 17 15:24:02 2022 +0300
>>
>>    PM: hibernate: Use kernel_can_power_off()
>>
> 
> Reverting that commit on top of v5.19-rc6 does indeed fix the problem here.
> 
> Any ideas?
> 
> 
> Greetings,
> 
> Daniel
> 


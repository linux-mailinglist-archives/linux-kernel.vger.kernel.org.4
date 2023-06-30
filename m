Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F91743E54
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjF3PLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjF3PLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:11:48 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF1CEC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:11:46 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4QszLQ5HWYz9sb4;
        Fri, 30 Jun 2023 17:11:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1688137902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ua30wMXPHiIzJC+EDhqRrAg0WgrJt2wqLGpN6dMTsnE=;
        b=XpHYz7NGak7KagCRXi00iobhb5iTDn6dzHL+UN7sESklYB+TogCXy613/A2FumWprXei0n
        6X1A+RhnvZEqW4sdcc7JHjPN83cudu6zSpPXYaVt55mjbsviJpx/Yj6omqvvjmZpyVmgGU
        X9YqrixgneF+iC6Bh6qynctyb6oKn7kSrKU939SMTbxnqo/Z983nCYKGcAVR8Foqr8/8nr
        FZ9rFPwZBSAvTd5kV8RN2BY0PeOExEoqV16PjmZuZdv3kmlYdd58bknXvssFPQ/t55MLWh
        dQkKHb08UlemwcT98nwa1+vcWUXnMRTASVw1l2eN0jIxzrg8RrPxJnCYNA8ouQ==
Message-ID: <afab1f5a-e581-3416-e2c2-238ea120655b@mailbox.org>
Date:   Fri, 30 Jun 2023 17:11:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
Content-Language: en-CA
To:     Alex Deucher <alexdeucher@gmail.com>,
        Sebastian Wick <sebastian.wick@redhat.com>
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
        amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        christian.koenig@amd.com
References: <20230627132323.115440-1-andrealmeid@igalia.com>
 <CA+hFU4z1pc=KUVVqyqfXEceUqMXQgh-qUnuB=1nkPELghvQO7w@mail.gmail.com>
 <CADnq5_MNVdtdcWKSz6dgmsjg+kEu8p5FVE+fkw_5BaXeG3QGow@mail.gmail.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <CADnq5_MNVdtdcWKSz6dgmsjg+kEu8p5FVE+fkw_5BaXeG3QGow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 852533966e5c2714efb
X-MBO-RS-META: o68zfrpg5xx44heqt4sp9rw33djooghd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/23 16:59, Alex Deucher wrote:
> On Fri, Jun 30, 2023 at 10:49 AM Sebastian Wick
> <sebastian.wick@redhat.com> wrote:
>> On Tue, Jun 27, 2023 at 3:23 PM André Almeida <andrealmeid@igalia.com> wrote:
>>>
>>> +Robustness
>>> +----------
>>> +
>>> +The only way to try to keep an application working after a reset is if it
>>> +complies with the robustness aspects of the graphical API that it is using.
>>> +
>>> +Graphical APIs provide ways to applications to deal with device resets. However,
>>> +there is no guarantee that the app will use such features correctly, and the
>>> +UMD can implement policies to close the app if it is a repeating offender,
>>> +likely in a broken loop. This is done to ensure that it does not keep blocking
>>> +the user interface from being correctly displayed. This should be done even if
>>> +the app is correct but happens to trigger some bug in the hardware/driver.
>>
>> I still don't think it's good to let the kernel arbitrarily kill
>> processes that it thinks are not well-behaved based on some heuristics
>> and policy.
>>
>> Can't this be outsourced to user space? Expose the information about
>> processes causing a device and let e.g. systemd deal with coming up
>> with a policy and with killing stuff.
> 
> I don't think it's the kernel doing the killing, it would be the UMD.
> E.g., if the app is guilty and doesn't support robustness the UMD can
> just call exit().

It would be safer to just ignore API calls[0], similarly to what is done until the application destroys the context with robustness. Calling exit() likely results in losing any unsaved work, whereas at least some applications might otherwise allow saving the work by other means.


[0] Possibly accompanied by a one-time message to stderr along the lines of "GPU reset detected but robustness not enabled in context, ignoring OpenGL API calls".

-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer


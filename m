Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32915618C62
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiKCXBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKCXBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:01:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A063D1FCFA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=BZusuybS/G3fqSyQufc4XqFjVIDA6e/RCUhyIeA4pkk=; b=4e0jSjJyo3uSGmUDYr4bVaykkA
        eKL9EwcPpusUgmkt8bqAa00Em2tbw6QGmG3xywMaHUiGhGhsYknTO1c92517h9IWKEYhjs1ZKWboI
        DAjEwIH7KUskZkSyUcqNLsYwKoxfzBsHXfVdOVvyQpF5dMWbLnsgZEfXZjjg5VMWCpQD8HWk9YCGf
        qDrmIppKZkvBoCUhdQptfDoqi7AttzXgRm7ne5oWRa4wV1OM8yLgjkvuA6pIJolVeN0UVe3SpoJ1x
        t9KMSN2JX/4BLjCmYKxm4OwcpmQuXBTvc4ef6yxEELlBJJSElG3vVGWS+eCo/4MUPf1JJF6C3OxKi
        8F8L3O3Q==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqjCx-001wBw-4n; Thu, 03 Nov 2022 23:01:11 +0000
Message-ID: <d5630f32-208a-77d2-91ed-58ef526ed086@infradead.org>
Date:   Thu, 3 Nov 2022 16:01:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH v2 1/3] drivers/accel: define kconfig and register a
 new major
Content-Language: en-US
To:     Oded Gabbay <ogabbay@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        stanislaw.gruszka@intel.com
References: <20221102203405.1797491-1-ogabbay@kernel.org>
 <20221102203405.1797491-2-ogabbay@kernel.org> <Y2MMCIe5wND2XPqE@kroah.com>
 <CAFCwf13uLj=P6u6FAcY8M5qAXoaBdb+Ha-TYj0j2FAZnFAPFYg@mail.gmail.com>
 <CAFCwf12yRUG4593ozJMEwaaJBKyWqXTTCjef9O_fzWdQBxVrtw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAFCwf12yRUG4593ozJMEwaaJBKyWqXTTCjef9O_fzWdQBxVrtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/22 13:39, Oded Gabbay wrote:
> On Thu, Nov 3, 2022 at 3:31 PM Oded Gabbay <ogabbay@kernel.org> wrote:
>>
>> On Thu, Nov 3, 2022 at 2:31 AM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> On Wed, Nov 02, 2022 at 10:34:03PM +0200, Oded Gabbay wrote:
>>>> --- /dev/null
>>>> +++ b/drivers/accel/Kconfig
>>>> @@ -0,0 +1,24 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only
>>>> +#
>>>> +# Compute Acceleration device configuration
>>>> +#
>>>> +# This framework provides support for compute acceleration devices, such
>>>> +# as, but not limited to, Machine-Learning and Deep-Learning acceleration
>>>> +# devices
>>>> +#
>>>> +menuconfig ACCEL
>>>> +     tristate "Compute Acceleration Framework"
>>>> +     depends on DRM
>>>> +     help
>>>> +       Framework for device drivers of compute acceleration devices, such
>>>> +       as, but not limited to, Machine-Learning and Deep-Learning
>>>> +       acceleration devices.
>>>> +       If you say Y here, you need to select the module that's right for
>>>> +       your acceleration device from the list below.
>>>> +       This framework is integrated with the DRM subsystem as compute
>>>> +       accelerators and GPUs share a lot in common and can use almost the
>>>> +       same infrastructure code.
>>>> +       Having said that, acceleration devices will have a different
>>>> +       major number than GPUs, and will be exposed to user-space using
>>>> +       different device files, called accel/accel* (in /dev, sysfs
>>>> +       and debugfs)
>>>
>>> Module name if "M" is chosen?
>> Will add
> So, unfortunately, the path of doing accel as a kernel module won't
> work cleanly (Thanks stanislaw for pointing this out to me).
> The reason is the circular dependency between drm and accel. drm calls
> accel exported symbols during init and when devices are registering
> (all the minor handling), and accel calls drm exported symbols because
> I don't want to duplicate the entire drm core code.

But DRM is a tristate symbol, so during drm init (loadable module), couldn't
it call accel init code (loadable module)?

Or are you saying that they only work together if both of them are builtin?

> I'll keep this menuconfig to provide the ability to disable this code
> for people who think it is too "experimental". And in the future, when
> drivers will join this subsystem, they will need this place for their
> kconfig.
> 
> Thanks,
> Oded

-- 
~Randy

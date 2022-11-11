Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7839262641F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiKKWEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiKKWEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:04:07 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0F8248DD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:04:06 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f27so15585011eje.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OZjjq/Y666UuQv+BQeivaEu2qR4Yd6nR9XcmCK1OHP8=;
        b=CJRrTjFyFrIxf1yiyysj959UgTMrhlihOUBpd/t7Fu/2JkEEVa4T+KTNDsBKUUjV9N
         kY5QVTH2xnjcFmgN56CiiL0p1AD1DfbHLXkzkMB+4+zIIfclmUqz8h8z42rMiX+KvmhE
         TMZ2Wa44ksGC4Z+C/Dph5Fxczn/G6xJ41hN/nW33B5lBJOvBBJ46IYYhgF4Y0XuVR+JF
         Wf39LIezDmf1wshIfHh3dXjffGXNFyo+JLDhtFRQ2+pnazb+YKcPs8+lrAV1VFF12mEV
         bG7UV4XtjvNCati6qL3O5Aufk8+wqurZKUZdcfSphY2XW1XIQZEwJ2SBuJyv8nqD0pce
         jdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZjjq/Y666UuQv+BQeivaEu2qR4Yd6nR9XcmCK1OHP8=;
        b=u/5n+5uYXoY12hSicm9KvKex+Eg/sgWLzdSvKsGZxOAv/ccJgOR1LC+ZELEdOpnYne
         CowguTxkYbSqIcZXCwcvKMiKY6rpb15+OMjBYb/D70fUNtmlEY2R6bfXcDahqKA7geiP
         jSDSHnurz0+z5Zi7OfUUlpU6dbZJIrbUQg33ioor3e09gcKHOu76j+NHOP9pft4PLIJ7
         PcBc2udYt9uDGUFG/Kkn2rZV4iU6+Rsf76Kg1BINcXu2g+AE5O7oz3vmkxd/+bpdOvPV
         VPZXYTMjDwWSbwcp2eHoU0gda7zHn/+xLiVGWRp0nMoPS3LQMDcAnOqkEvdD6CNKN/Vo
         ol3w==
X-Gm-Message-State: ANoB5pmPT0gQuUcqBv27y/nOTvpujA1L8UFZqHkw3kBLKBpAVZ40UdH9
        UlfoDfHmxkedW/a1E3v3Wp9rxj8jE1Ya608hK3U=
X-Google-Smtp-Source: AA0mqf7boUZCG6l/FLFLHrLLcWtLXCito8vLVSUMq3WJmYrAdm9zVTs15avreptgXVQkuL0yrySnY5u6ZYWW9BMZcIw=
X-Received: by 2002:a17:906:a14:b0:7ad:90dc:eaf2 with SMTP id
 w20-20020a1709060a1400b007ad90dceaf2mr3495432ejf.526.1668204244513; Fri, 11
 Nov 2022 14:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20221106210225.2065371-1-ogabbay@kernel.org>
In-Reply-To: <20221106210225.2065371-1-ogabbay@kernel.org>
From:   Christopher Friedt <chrisfriedt@gmail.com>
Date:   Fri, 11 Nov 2022 17:03:52 -0500
Message-ID: <CAF4BF-Qo_3ZE+hwF2e-gfrQHXpZU+uyyxaOf29YLcp7wh_eCFg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/3] new subsystem for compute accelerator devices
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
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
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, cfriedt@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oded,

On Sun, Nov 6, 2022 at 4:03 PM Oded Gabbay <ogabbay@kernel.org> wrote:
> The patches are in the following repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git/log/?h=accel_v3
>
> As in v2, The HEAD of that branch is a commit adding a dummy driver that
> registers an accel device using the new framework. This can be served
> as a simple reference. I have checked inserting and removing the dummy driver,
> and opening and closing /dev/accel/accel0 and nothing got broken :)
>
> v1 cover letter:
> https://lkml.org/lkml/2022/10/22/544
>
> v2 cover letter:
> https://lore.kernel.org/lkml/20221102203405.1797491-1-ogabbay@kernel.org/T/

I was in the room at Plumbers when a lot of this was discussed (in
2022 and also 2019), but I haven't really had an opportunity to
provide feedback until now. In general, I think it's great and thanks
for pushing it forward and getting feedback.

The v1 cover letter mentioned RAS (reliability, availability,
serviceability) and Dave also mentioned it here [1]. There was a
suggestion to use Netlink. It's an area that I'm fairly interested in
because I do a lot of development on the firmware side (and
specifically, with Zephyr).

Personally, I think Netlink could be one option for serializing and
deserializing RAS information but it would be helpful for that
interface to be somewhat flexible, like a void * and length, and to
provide userspace the capability of querying which RAS formats are
supported.

For example, AntMicro used OpenAMP + rpmsg in their NVMe accelerator,
and gave a talk on it at ZDS and Plumbers this year [2][3].

In Zephyr, the LGPL license for Netlink might be a non-starter
(although I'm no lawyer). However, Zephyr does already support
OpenAMP, protobufs, json, and will soon support Thrift.

Some companies might prefer to use Netlink. Others might prefer to use
ASN.1. Some companies might prefer to use key-value pairs and limit
the parameters and messages to uint32s. Some might handle all of the
RAS details in-kernel, while others might want the kernel to act more
like a transport to firmware.

Companies already producing accelerators may have a particular
preference for serialization / deserialization in their own
datacenters.

With that, it would be helpful to be able to query RAS capabilities via ioctl.

#define ACCEL_CAP_RAS_KEY_VAL_32 BIT(0)
#define ACCEL_CAP_RAS_NETLINK BIT(1)
#define ACCEL_CAP_RAS_JSON BIT(2)
#define ACCEL_CAP_RAS_PROTOBUF BIT(3)
#define ACCEL_CAP_RAS_GRPC BIT(4)
#define ACCEL_CAP_RAS_THRIFT BIT(5)
#define ACCEL_CAP_RAS_JSON BIT(6)
#define ACCEL_CAP_RAS_ASN1 BIT(7)

or something along those lines. Anyway, just putting the idea out there.

I'm sure there are a lot of opinions on this topic and that there are
a lot of implications of using this or that serialization format.
Obviously there can be security implications as well.

Apologies if I've already missed some of this discussion.

Cheers,

C

[1] https://airlied.blogspot.com/2022/09/accelerators-bof-outcomes-summary.html
[2] https://zephyr2022.sched.com/event/10CFD/open-source-nvme-ai-accelerator-platform-with-zephyr-karol-gugala-antmicro
[3] https://lpc.events/event/16/contributions/1245/

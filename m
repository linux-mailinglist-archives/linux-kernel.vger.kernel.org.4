Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50796948A0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBMOum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjBMOue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:50:34 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40C43A9E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:50:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cq19so10510148edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XHrlyv3VyBysVB2vB16EL5JMPdmOhZB3gs14NG2Wfk=;
        b=hODO31L9voFNHgx37fNSk0VaS6229BFk31vo2XTfuT0zYRz6l3DvaK2lsou8kKglxU
         7JpRZ5gRtD9rKL3ePTrsPKMmLkZ6oE5+6Rch79Z+OLuguopFCwdD5Goe+I9E8e4yQ3mQ
         Pie9z2my14d+29N0jBSTayjbYrVLKTc4eulcyLc1UbfsLABLkjgqr4fRfqd5Mx9j0Zyg
         XMBw+uukbt1gq2NrEun0trRcAJeSM4gCj9Tytkn2WYRMyA8jh61LwJTOXDQIY1+4lsWK
         GyDeFSR5qbSZqUAhWKD3zfDMphuDkwfyZIzg+BcmIb+SMHsJGZ5DmeCgnm4AasM+m683
         W5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XHrlyv3VyBysVB2vB16EL5JMPdmOhZB3gs14NG2Wfk=;
        b=Sk6fG5QVKpnQXCVSIP+AMrFcJ1SCpVBqbCSi9MIr3MFkVJ833qawpYkh8jH6xYn7Iq
         XhHjkVaicbQCic9nxjwD2qlsuK7iU3tt0jaftDdwIFfjGL+TDt6Vt6fEXKz8XiSdGBHd
         FXr3TRGpOaidl+BgdITfESheYpEAfDka1Zm0Su1tzQ5XJUvhFBLoFOTTSUKqXjwulaCQ
         kzIWcu7wSsZPJ9K79oMAAdwaZD1yEdQrNjE1AYtcBCcMB2Oy+EKRDl72AalZNFj4exXz
         4T8QcB00FSDvI1gsvM7IMylwjwlYXeBryFWa3yFmMyzFbHev+9WrovWAu19uWTG5GNU6
         4/Ow==
X-Gm-Message-State: AO0yUKUNM4nddMv4B7ImBtQeYgo+dW7NjgL2+ZcLbBf2+AOTWVlhSKm9
        9IBHSZaUU9co3/aPtqclFq5l/wGO7NguB5K99KLM
X-Google-Smtp-Source: AK7set986gHeQZ+LUl/OJFRwEbF4YISJu+NRUA3Vy6hwDz/7YCHyt6avdlp6ECwWRadzl1NTeyk9hLPTJt+X9IPzL+s=
X-Received: by 2002:a50:ab14:0:b0:4ac:bb4e:c38c with SMTP id
 s20-20020a50ab14000000b004acbb4ec38cmr2961686edc.0.1676299829307; Mon, 13 Feb
 2023 06:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-2-xieyongji@bytedance.com>
 <20221219023253-mutt-send-email-mst@kernel.org> <CACycT3utDJFZtWzqCUXJaqRjkCXPMTAi+VJd3g6dw25vWqaduw@mail.gmail.com>
 <20230127032039-mutt-send-email-mst@kernel.org> <CACycT3u=vULuZ9-ZakBjxmbu88iUb+xB2mHJUnHA_8SuUV7H4w@mail.gmail.com>
 <20230213065116-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230213065116-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 13 Feb 2023 22:50:18 +0800
Message-ID: <CACycT3uY1dfP=5d1go+POh7-J1tUMW+9RXi92KtcFJYMzq-bOQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export irq_create_affinity_masks()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 8:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jan 30, 2023 at 07:53:55PM +0800, Yongji Xie wrote:
> > On Fri, Jan 27, 2023 at 4:22 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Mon, Dec 19, 2022 at 05:36:02PM +0800, Yongji Xie wrote:
> > > > On Mon, Dec 19, 2022 at 3:33 PM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> > > > >
> > > > > On Mon, Dec 05, 2022 at 04:41:17PM +0800, Xie Yongji wrote:
> > > > > > Export irq_create_affinity_masks() so that some modules
> > > > > > can make use of it to implement interrupt affinity
> > > > > > spreading mechanism.
> > > > > >
> > > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > >
> > > > > So this got nacked, what's the plan now?
> > > > >
> > > >
> > > > I=E2=80=98d like to check with Christoph again first.
> > > >
> > > > Hi Christoph,
> > > >
> > > > Jason will post some patches to get rid of the DMA API for vDPA
> > > > simulators. And the irq affinity algorithm is independent of the IR=
Q
> > > > subsystem IIUC. So could you allow this patch so that we can reuse =
the
> > > > algorithm to select the best CPU (per-cpu affinity if possible, or =
at
> > > > least per-node) to run the virtqueue's irq callback.
> > > >
> > > > Thanks,
> > > > Yongji
> > >
> > > I think you need to explain why you are building low level
> > > affinity masks.
> >
> > In VDUSE case, we use workqueue to run the virtqueue's irq callback.
> > Now I want to queue the irq callback kwork to one specific CPU to get
> > per-cpu affinity if possible, or at least per-node. So I need to use
> > this function to build the low level affinity masks for each
> > virtqueue.
> >
> > > what's the plan now?
> > >
> >
> > If there is no objection, I'll post a new version.
> >
> > Thanks,
> > Yongji
>
> I doubt you made a convicing case here - I think Christoph was saying if
> it is not an irq it should not use an irq affinity API.
> So a new API possibly sharing implementation with irq affinity
> is called for then? Maybe.
>

I'm not sure I get your point on sharing implementation.

I can try to split irq_create_affinity_masks() into a common part and
an irq specific part, and move the common part to a common dir such as
/lib and export it. Then we can use the common part to build a new API
for usage.

But I'm afraid that there will be no difference between the new API
and the irq affinity API except for the name since the new API is
still used for irq affinity management. That means we may still need
the irq specific part in the new API. For example, the virtio-blk
driver doesn't know whether the virtio device is a software-defined
vDPA device or a PCI device, so it will pass a structure irq_affinity
to those APIs, then both the new API and irq affinity API still need
to handle it.

Thanks,
Yongji

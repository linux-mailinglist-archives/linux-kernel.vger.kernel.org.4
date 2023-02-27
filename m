Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3F66A3BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjB0HSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjB0HSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:18:47 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F8C9742
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:18:46 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id h18-20020a4abb92000000b00525397f569fso855997oop.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AV+BUrqsjS8wgrqlLbYQIjVBrtakZzEzQXRY/JnkoOE=;
        b=s5wFvNf/cESyyJoHCBYL7vja74vNUnHe4673jYexMz0cSgnD/8E/cJYARF93FyMSz9
         L1uSVa6tenaLNQuIiePz1xMoPn6/DI2/8Pj7FdnV8EKiF3LNtcM7G0uZJUKG9CwWvE1h
         RnCpTO/yevwPKl9pp7bSyr8jr6u0ygzzOsrur8ydr4Y+nVRSKOGSImpaqKakMmgYneVl
         4IiD7gMLcsyZldXY4YT6UkyEfaQmBS/GFy51+vNKgXB2yc8pW8jhA818iy9A8ddGhBBS
         vpRcv0gnCalPdMPykXljdVLdylWrZVghCLB8fHdiK7XRjTngPX8JXD425gXzZzC1r0Rr
         2qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AV+BUrqsjS8wgrqlLbYQIjVBrtakZzEzQXRY/JnkoOE=;
        b=Zp7+WJIyw5vxPzskQvFKSxnNUCFY8xNg8xHtZOSEJ96o7xwM+TFMwZWpVuLR4O8LEc
         +0YXjMekdm2yeYQyzzkLkcsEk67HDJDNAWLBRO2EZ6luGvgHLQSqIgHOzm0vuF9dyr1V
         U5St/krDf2ual9hv614ocyLbWVQKOryVm/EB3OPW7bxTTxar731eoDoQ9Bqhx7VDGFB6
         6JaUPxBN04SJ5AcdSaxxgiK3nlP5r0wLBkIOSU/2JOIRtTxoVizPpsTkevIX4JhtFu6G
         HJjyxUGhS8TAkCEkkAv7uqPq4RU+71rQQWF0tNPvWtnsDQS0Hi2pnI3lJROxuujlodLt
         hwjw==
X-Gm-Message-State: AO0yUKWkTPQyxfAzjplXK1o2HLU3I1/8Oz5ZgPJuJBE2nhOmRwCFkcWo
        Tb2mbqjcR44N7yttn/5h57UL5DV8XYrqpk3gi6gdLQ==
X-Google-Smtp-Source: AK7set9/v6iYV6pbVgTZkdgLBEJbfS32Dhr+ap8s410dZZc/crOH2vqfCxMZEcuLD2H4hXYLTUT1qD13nshtkxSnQ44=
X-Received: by 2002:a4a:e914:0:b0:525:3b4f:ee88 with SMTP id
 bx20-20020a4ae914000000b005253b4fee88mr3337346oob.0.1677482325637; Sun, 26
 Feb 2023 23:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20230224195313.1877313-1-jiangzp@google.com> <20230224115310.kernel.v2.1.If0578b001c1f12567f2ebcac5856507f1adee745@changeid>
 <CABBYNZ+yVWssa09NB+ahp-N87sLXRqYF58-GJK-Vx8jn-Sa5Uw@mail.gmail.com> <CAB4PzUrO32Z1AF-3UJviYqTr3YvachGgJ7NiqkNW46ioWigtfw@mail.gmail.com>
In-Reply-To: <CAB4PzUrO32Z1AF-3UJviYqTr3YvachGgJ7NiqkNW46ioWigtfw@mail.gmail.com>
From:   Zhengping Jiang <jiangzp@google.com>
Date:   Sun, 26 Feb 2023 23:18:34 -0800
Message-ID: <CAB4PzUoErDkUzyj6sFQc_CSa7hibucX42yY+oVGw7C4DcJdQFA@mail.gmail.com>
Subject: Re: [kernel PATCH v2 1/1] Bluetooth: hci_sync: clear workqueue before
 clear mgmt cmd
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        mmandlik@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

I have a question. Given that each command in the cmd_sync queue
should clean up the memory in a callback function. I was wondering if
the call to cmd_complete_rsp in __mgmt_power_off function is still
necessary? Will this always risk a race condition that cmd has been
released when the complete callback or _sync function is run?

Thanks,
Zhengping

On Fri, Feb 24, 2023 at 2:37=E2=80=AFPM Zhengping Jiang <jiangzp@google.com=
> wrote:
>
> Hi Luiz,
>
> > Any particular reason why you are not using hci_cmd_sync_clear
> > instead?
>
> That is a good question and we used hci_cmd_sync_clear in the first
> version, but it will clear the queue and also close the timer. As a
> result, when the adapter is turned on again, the timer will not
> schedule any new jobs. So the option is to use hci_cmd_sync_clear and
> re-initiate the queue or to write a new function which only clears the
> queue.
>
> > We also may want to move the clearing logic to
> > hci_dev_close_sync since it should be equivalent to
> > hci_request_cancel_all.
>
> I actually have a question here. I saw
> "drain_workqueue(hdev->workqueue)" in hci_dev_close_sync and thought
> it should force clearing the cmd_sync queue. But it seems cannot
> prevent the use-after-free situation.
>
> Any suggestions to improve the solution?
>
> Thanks,
> Zhengping
>
>
> On Fri, Feb 24, 2023 at 1:02 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Zhengping,
> >
> > On Fri, Feb 24, 2023 at 11:53 AM Zhengping Jiang <jiangzp@google.com> w=
rote:
> > >
> > > Clear cmd_sync_work queue before clearing the mgmt cmd list to avoid
> > > racing conditions which cause use-after-free.
> > >
> > > When powering off the adapter, the mgmt cmd list will be cleared. If =
a
> > > work is queued in the cmd_sync_work queue at the same time, it will
> > > cause the risk of use-after-free, as the cmd pointer is not checked
> > > before use.
> > >
> > > Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> > > ---
> > >
> > > Changes in v2:
> > > - Add function to clear the queue without stop the timer
> > >
> > > Changes in v1:
> > > - Clear cmd_sync_work queue before clearing the mgmt cmd list
> > >
> > >  net/bluetooth/hci_sync.c | 21 ++++++++++++++++++++-
> > >  1 file changed, 20 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index 117eedb6f709..b70365dfff0c 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -636,6 +636,23 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
> > >         INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_exp=
ire);
> > >  }
> > >
> > > +static void hci_pend_cmd_sync_clear(struct hci_dev *hdev)
> > > +{
> > > +       struct hci_cmd_sync_work_entry *entry, *tmp;
> > > +
> > > +       mutex_lock(&hdev->cmd_sync_work_lock);
> > > +       list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_lis=
t, list) {
> > > +               if (entry->destroy) {
> > > +                       hci_req_sync_lock(hdev);
> > > +                       entry->destroy(hdev, entry->data, -ECANCELED)=
;
> > > +                       hci_req_sync_unlock(hdev);
> > > +               }
> > > +               list_del(&entry->list);
> > > +               kfree(entry);
> > > +       }
> > > +       mutex_unlock(&hdev->cmd_sync_work_lock);
> > > +}
> > > +
> > >  void hci_cmd_sync_clear(struct hci_dev *hdev)
> > >  {
> > >         struct hci_cmd_sync_work_entry *entry, *tmp;
> > > @@ -4842,8 +4859,10 @@ int hci_dev_close_sync(struct hci_dev *hdev)
> > >
> > >         if (!auto_off && hdev->dev_type =3D=3D HCI_PRIMARY &&
> > >             !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> > > -           hci_dev_test_flag(hdev, HCI_MGMT))
> > > +           hci_dev_test_flag(hdev, HCI_MGMT)) {
> > > +               hci_pend_cmd_sync_clear(hdev);
> >
> > Any particular reason why you are not using hci_cmd_sync_clear
> > instead? We also may want to move the clearing logic to
> > hci_dev_close_sync since it should be equivalent to
> > hci_request_cancel_all.
> >
> > >                 __mgmt_power_off(hdev);
> > > +       }
> > >
> > >         hci_inquiry_cache_flush(hdev);
> > >         hci_pend_le_actions_clear(hdev);
> > > --
> > > 2.39.2.722.g9855ee24e9-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz

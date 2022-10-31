Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4C8613F11
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJaUhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJaUhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:37:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E6013D7F;
        Mon, 31 Oct 2022 13:37:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t4so7925555lfp.2;
        Mon, 31 Oct 2022 13:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEuILt375Kw/g/rl5LYUxYeoh6illHaCRAd/FWiXGcc=;
        b=dceawVHMgDJ8mJRDpyTjb0FUColgU/gZtA0lTbGynB0lIzoMyQ2cXk0gRVNVSud3t9
         8tc864Uc7iGJHL4kRN02YtogOBvNEAmep4gf+0uEUwSiz4y2jHsfaAgr0S0z7RIf06I1
         +bd1W2BfRf8w0EAW9aRm0HGFMg2jH3N81ri7Zw3+RSENvuwRDRFdb6AtFKr6rBD1ck7k
         jxYkPfVW6NNpRw0/zfOgPGD8jC7/3T+3CQdfJE9xjNuaaX3OEM0a7EByb1CCw0NiCbJ5
         x4gxPtIz4OP7moZnhopICG4LdEYWK2TYkU4vhhAUrGAdT+V8UyVMKMseFhO5MSaPNHgq
         JjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEuILt375Kw/g/rl5LYUxYeoh6illHaCRAd/FWiXGcc=;
        b=yphtUd8OWGVEowdaoy9A+vpswE5WXur4wyFPtXz8xbrhj5w44xaacXTyUUyILZvHl7
         ItM6qaBsr5psHXdrtFZxyQMsFxAE14GfXQzJC8+nyq+lZdyNd+/XYXbkIL5HjHIUYAus
         FJgQZILmnUZNWBoEjWNhigg+5YSjll1CnmE77TDUC/Wjw6LLQYMDH3YCL2/szcLsyZXZ
         GWyA/gSekM0i/NSp7H30VkbCT/C6VLmMe51x6aoJt7r85MKfA0mCxN+hwhP/R7O+cqn3
         ceOuZvoY8JzjzuaZo521iKjyUTr55hA4NR+4+IW96e2dvCiEQ0Qjz0H8NDsAaBiZaGR+
         UDIg==
X-Gm-Message-State: ACrzQf0B3yGZM14+J0gBbYbgc6kBewl1ecBsTUKf/pmcgYKuC35Ibh0S
        +OfqtgOPVPmhhkjGyBurh/yAp3UsJug+WirA8U0S3s6bGHY=
X-Google-Smtp-Source: AMsMyM6ugRz/XCGpnD/1ZSaMq58hkhm8hYQDXmbHXrhmE081KbPtwW4u7JK98FCDAG6PK4wtlh9ffFly+a/ZZNMc+ZA=
X-Received: by 2002:a05:6512:483:b0:4a2:6905:dfae with SMTP id
 v3-20020a056512048300b004a26905dfaemr6372774lfq.57.1667248635563; Mon, 31 Oct
 2022 13:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <aac93511-d5e5-7a1b-6b1c-65e008ce068e@o2.pl>
In-Reply-To: <aac93511-d5e5-7a1b-6b1c-65e008ce068e@o2.pl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Oct 2022 13:37:04 -0700
Message-ID: <CABBYNZKXYaRT_N9YTHX2aKRBRVHhORejT=+LJNvrJgL2QYjSLA@mail.gmail.com>
Subject: Re: "Bluetooth: hci0: HCI_REQ-0xfcf0" errors in dmesg
To:     =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     Brian Gix <brian.gix@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 31, 2022 at 1:15 PM Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl> wr=
ote:
>
> Hello,
>
> On 6.1.0-rc3, I have been seeing this error message in dmesg:
>
>         Bluetooth: hci0: HCI_REQ-0xfcf0
>
> It is printed on every boot, resume from suspend and rfkill unblock of th=
e Bluetooth device.
> The device seems to be functioning normally though (but I have done limit=
ed testing only).
>
> After some investigation, it turned out to be caused by
>         commit dd50a864ffae ("Bluetooth: Delete unreferenced hci_request =
code")
> which modified hci_req_add() in net/bluetooth/hci_request.c to always pri=
nt an error message
> when that function is executed.
>
> I have added dump_stack() to hci_req_add() and got the following backtrac=
es:
>
> On boot:
>
> [   18.487766] Bluetooth: hci0: RTL: fw version 0xab6b705c
> [   18.548951] Bluetooth: hci0: HCI_REQ-0xfcf0
> [   18.548961] CPU: 3 PID: 108 Comm: kworker/u9:0 Not tainted 6.1.0-rc3un=
if4-00001-gb33a0948e932 #86
> [   18.548965] Hardware name: HP HP Laptop 17-by0xxx/84CA, BIOS F.66 03/2=
9/2022
> [   18.548968] Workqueue: hci0 hci_power_on [bluetooth]
> [   18.549018] Call Trace:
> [   18.549020]  <TASK>
> [   18.549022]  dump_stack_lvl+0x38/0x4d
> [   18.549030]  dump_stack+0x10/0x16
> [   18.549035]  hci_req_add+0x47/0x70 [bluetooth]
> [   18.549093]  msft_set_filter_enable+0x59/0x90 [bluetooth]
> [   18.549147]  msft_do_open+0x131/0x220 [bluetooth]
> [   18.549198]  hci_dev_open_sync+0x646/0xc20 [bluetooth]
> [   18.549249]  hci_dev_do_open+0x2a/0x60 [bluetooth]
> [   18.549282]  hci_power_on+0x53/0x210 [bluetooth]
> [   18.549317]  process_one_work+0x21f/0x3f0
> [   18.549323]  worker_thread+0x4a/0x3c0
> [   18.549328]  ? process_one_work+0x3f0/0x3f0
> [   18.549332]  kthread+0xff/0x130
> [   18.549336]  ? kthread_complete_and_exit+0x20/0x20
> [   18.549340]  ret_from_fork+0x22/0x30
> [   18.549347]  </TASK>
> [   21.165060] EXT4-fs (dm-7): mounted filesystem with ordered data mode.=
 Quota mode: none.
>
> on rfkill unblock:
>
> [ 1671.040970] Bluetooth: hci0: HCI_REQ-0xfcf0
> [ 1671.040992] CPU: 3 PID: 5006 Comm: kworker/u9:2 Not tainted 6.1.0-rc3u=
nif4-00001-gb33a0948e932 #86
> [ 1671.041005] Hardware name: HP HP Laptop 17-by0xxx/84CA, BIOS F.66 03/2=
9/2022
> [ 1671.041012] Workqueue: hci0 hci_cmd_sync_work [bluetooth]
> [ 1671.041194] Call Trace:
> [ 1671.041200]  <TASK>
> [ 1671.041208]  dump_stack_lvl+0x38/0x4d
> [ 1671.041227]  dump_stack+0x10/0x16
> [ 1671.041241]  hci_req_add+0x47/0x70 [bluetooth]
> [ 1671.041408]  msft_set_filter_enable+0x59/0x90 [bluetooth]
> [ 1671.041579]  msft_do_open+0x131/0x220 [bluetooth]
> [ 1671.041683]  hci_dev_open_sync+0x646/0xc20 [bluetooth]
> [ 1671.041787]  hci_set_powered_sync+0xd4/0x240 [bluetooth]
> [ 1671.041887]  set_powered_sync+0x20/0x60 [bluetooth]
> [ 1671.041975]  hci_cmd_sync_work+0xa8/0x150 [bluetooth]
> [ 1671.042079]  process_one_work+0x21f/0x3f0
> [ 1671.042092]  worker_thread+0x4a/0x3c0
> [ 1671.042102]  ? process_one_work+0x3f0/0x3f0
> [ 1671.042111]  kthread+0xff/0x130
> [ 1671.042119]  ? kthread_complete_and_exit+0x20/0x20
> [ 1671.042128]  ret_from_fork+0x22/0x30
> [ 1671.042142]  </TASK>
>
> My hardware: HP laptop 17-by0001nw, device is a Realtek combo card:
>
> "Realtek RTL8822BE 802.11 ac 2=C3=972 WiFi + Bluetooth 4.2 Combo Adapter =
(MU-MIMO supported)"
>
> I am ready to provide additional information and testing, if need be.

@Gix, Brian Can you give a look, we should probably convert the
msft_set_filter_enable to use the cmd_sync instead.

> Greetings,
>
> Mateusz Jo=C5=84czyk
>


--=20
Luiz Augusto von Dentz

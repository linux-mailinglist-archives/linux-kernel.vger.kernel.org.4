Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A8B6639CA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjAJHRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjAJHRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:17:02 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A5CBED;
        Mon,  9 Jan 2023 23:17:00 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pF8sS-0001iG-11; Tue, 10 Jan 2023 08:16:56 +0100
Message-ID: <252b1fe4-ccc2-4ea8-1da5-9a60f7378fd6@leemhuis.info>
Date:   Tue, 10 Jan 2023 08:16:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [6.2][regression] after commit
 cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae stopping working wifi mt7921e
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Felix Fietkau <nbd@nbd.name>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     lorenzo@kernel.org, sujuan.chen@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, spasswolf@web.de
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre+XJS_s5FgVteYA@mail.gmail.com>
 <678adc67-9e46-3eef-f274-c951b121570f@nbd.name>
 <CABXGCsMUbs+bf=tWnx98r4v_JzVmYdVyOos9EhcGJ6jnEwathA@mail.gmail.com>
 <a30d8580-936a-79e4-c1c7-70f3d3b8da35@nbd.name>
 <CABXGCsNJKy2SQffeU+uaua5SM_77YiGKdPLRdzSF3F+ShpF+5w@mail.gmail.com>
 <3cb53fbd-0bee-22f9-bba2-6ac4a87db521@nbd.name>
 <bb480259-2c0f-deab-ab6e-5101e09eb189@leemhuis.info>
 <6538f66a-bc3e-6f16-180a-50ef37b02e98@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <6538f66a-bc3e-6f16-180a-50ef37b02e98@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673335020;bb34778c;
X-HE-SMSGID: 1pF8sS-0001iG-11
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing spasswolf@web.de]

On 09.01.23 08:32, Linux kernel regression tracking (Thorsten Leemhuis)
wrote:
> On 04.01.23 15:20, Thorsten Leemhuis wrote:
>> Hi, this is your Linux kernel regression tracker. Top-posting for once,
>> to make this easily accessible to everyone.
>>
>> Felix, Lorenzo, did below fix for the regression
> 
> There is another report about an issue with mediatek wifi in 6.2-rc:
> https://bugzilla.kernel.org/show_bug.cgi?id=216901

FWIW, "spasswolf" in that ticket posted a patch that according to the
reporter of that bug fixes the issue:
https://bugzilla.kernel.org/show_bug.cgi?id=216901#c5

I only took a brief look, but it seems it does a subset of what Felix
patch does.

> To me this looks like a duplicate of the report that started this thread.
> 
> (side note: there was another, earlier report that might be a dupe, too:
> https://bugzilla.kernel.org/show_bug.cgi?id=216829 )>
>> Mikhail reported make
>> any progress to get mainlined? It doesn't look like it from here, but I
>> suspect I missed something, that's why I'm asking.
> 
> No reply. :-((

Still no reply. I wonder if I'm holding things wrong. But well, let's
wait one more day before escalating this further.

Ciao, Thorsten

> That lack of feedback is another reason why I'm CCing the network
> maintainers now, as the mediatek wifi issues in 6.2-rc (this one) and
> 6.1 ([1]) are already hitting a nerve here because the fixes are
> progressing so slowly. I known, it was holiday season, but seems quite a
> few people ran into these regressions already, hence we IMHO should
> really try to aim fixing both this week.
> 
> [1] see
> https://lore.kernel.org/all/ac023262-c6cb-01ad-aeee-2dbf379f4c37@leemhuis.info/
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke
> 
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>>
>> #regzbot poke
>>
>> On 21.12.22 18:17, Felix Fietkau wrote:
>>> On 21.12.22 17:46, Mikhail Gavrilov wrote:
>>>> On Wed, Dec 21, 2022 at 7:12 PM Felix Fietkau <nbd@nbd.name> wrote:
>>>>>
>>>>> Thanks! I guess I focused on the wrong part of your kernel log
>>>>> initially. After more code review, I found that there is in fact a DMA
>>>>> related bug in the commit that your bisection pointed to, which happened
>>>>> to uncover and trigger the deadlock fixed by my other patch.
>>>>>
>>>>> So here's my fix for the DMA issue:
>>>>> ---
>>>> [cutted]
>>>>>                 qbuf.skip_unmap = false;
>>>>> -               if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
>>>>> +               if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {
>>>>>                         dma_unmap_single(dev->dma_dev, addr, len,
>>>>>                                          DMA_FROM_DEVICE);
>>>>>                         skb_free_frag(buf);
>>>>>
>>>>
>>>> Sorry for stupid question.
>>>>
>>>> Do you have a separate branch?
>>>> I see that the code is differ between master branch and the patch.
>>>>
>>>> For example in patch the line:
>>>> - if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
>>>> replaced by the line:
>>>> + if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {
>>>>
>>>> But in master branch
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/mediatek/mt76/dma.c?id=b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf#n604
>>>> after line:
>>>> qbuf.skip_unmap = false;
>>>> followed the line:
>>>> mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t);
>>>> without if condition.
>>>>
>>>> So I'm stuck applying the patch :(
>>> Sorry, I worked on a tree that had other pending fixes applied.
>>> Please try this:
>>>
>>>
>>> --- a/drivers/net/wireless/mediatek/mt76/dma.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
>>> @@ -205,6 +205,52 @@ mt76_dma_queue_reset(struct mt76_dev *dev, struct
>>> mt76_queue *q)
>>>      mt76_dma_sync_idx(dev, q);
>>>  }
>>>  
>>> +static int
>>> +mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
>>> +            struct mt76_queue_buf *buf, void *data)
>>> +{
>>> +    struct mt76_desc *desc = &q->desc[q->head];
>>> +    struct mt76_queue_entry *entry = &q->entry[q->head];
>>> +    struct mt76_txwi_cache *txwi = NULL;
>>> +    u32 buf1 = 0, ctrl;
>>> +    int idx = q->head;
>>> +    int rx_token;
>>> +
>>> +    ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
>>> +
>>> +    if ((q->flags & MT_QFLAG_WED) &&
>>> +        FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX) {
>>> +        txwi = mt76_get_rxwi(dev);
>>> +        if (!txwi)
>>> +            return -ENOMEM;
>>> +
>>> +        rx_token = mt76_rx_token_consume(dev, data, txwi, buf->addr);
>>> +        if (rx_token < 0) {
>>> +            mt76_put_rxwi(dev, txwi);
>>> +            return -ENOMEM;
>>> +        }
>>> +
>>> +        buf1 |= FIELD_PREP(MT_DMA_CTL_TOKEN, rx_token);
>>> +        ctrl |= MT_DMA_CTL_TO_HOST;
>>> +    }
>>> +
>>> +    WRITE_ONCE(desc->buf0, cpu_to_le32(buf->addr));
>>> +    WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
>>> +    WRITE_ONCE(desc->ctrl, cpu_to_le32(ctrl));
>>> +    WRITE_ONCE(desc->info, 0);
>>> +
>>> +    entry->dma_addr[0] = buf->addr;
>>> +    entry->dma_len[0] = buf->len;
>>> +    entry->txwi = txwi;
>>> +    entry->buf = data;
>>> +    entry->wcid = 0xffff;
>>> +    entry->skip_buf1 = true;
>>> +    q->head = (q->head + 1) % q->ndesc;
>>> +    q->queued++;
>>> +
>>> +    return idx;
>>> +}
>>> +
>>>  static int
>>>  mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
>>>           struct mt76_queue_buf *buf, int nbufs, u32 info,
>>> @@ -212,65 +258,51 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct
>>> mt76_queue *q,
>>>  {
>>>      struct mt76_queue_entry *entry;
>>>      struct mt76_desc *desc;
>>> -    u32 ctrl;
>>>      int i, idx = -1;
>>> +    u32 ctrl, next;
>>> +
>>> +    if (txwi) {
>>> +        q->entry[q->head].txwi = DMA_DUMMY_DATA;
>>> +        q->entry[q->head].skip_buf0 = true;
>>> +    }
>>>  
>>>      for (i = 0; i < nbufs; i += 2, buf += 2) {
>>>          u32 buf0 = buf[0].addr, buf1 = 0;
>>>  
>>>          idx = q->head;
>>> -        q->head = (q->head + 1) % q->ndesc;
>>> +        next = (q->head + 1) % q->ndesc;
>>>  
>>>          desc = &q->desc[idx];
>>>          entry = &q->entry[idx];
>>>  
>>> -        if ((q->flags & MT_QFLAG_WED) &&
>>> -            FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX) {
>>> -            struct mt76_txwi_cache *t = txwi;
>>> -            int rx_token;
>>> -
>>> -            if (!t)
>>> -                return -ENOMEM;
>>> -
>>> -            rx_token = mt76_rx_token_consume(dev, (void *)skb, t,
>>> -                             buf[0].addr);
>>> -            buf1 |= FIELD_PREP(MT_DMA_CTL_TOKEN, rx_token);
>>> -            ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len) |
>>> -                   MT_DMA_CTL_TO_HOST;
>>> -        } else {
>>> -            if (txwi) {
>>> -                q->entry[q->head].txwi = DMA_DUMMY_DATA;
>>> -                q->entry[q->head].skip_buf0 = true;
>>> -            }
>>> -
>>> -            if (buf[0].skip_unmap)
>>> -                entry->skip_buf0 = true;
>>> -            entry->skip_buf1 = i == nbufs - 1;
>>> -
>>> -            entry->dma_addr[0] = buf[0].addr;
>>> -            entry->dma_len[0] = buf[0].len;
>>> -
>>> -            ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
>>> -            if (i < nbufs - 1) {
>>> -                entry->dma_addr[1] = buf[1].addr;
>>> -                entry->dma_len[1] = buf[1].len;
>>> -                buf1 = buf[1].addr;
>>> -                ctrl |= FIELD_PREP(MT_DMA_CTL_SD_LEN1, buf[1].len);
>>> -                if (buf[1].skip_unmap)
>>> -                    entry->skip_buf1 = true;
>>> -            }
>>> -
>>> -            if (i == nbufs - 1)
>>> -                ctrl |= MT_DMA_CTL_LAST_SEC0;
>>> -            else if (i == nbufs - 2)
>>> -                ctrl |= MT_DMA_CTL_LAST_SEC1;
>>> +        if (buf[0].skip_unmap)
>>> +            entry->skip_buf0 = true;
>>> +        entry->skip_buf1 = i == nbufs - 1;
>>> +
>>> +        entry->dma_addr[0] = buf[0].addr;
>>> +        entry->dma_len[0] = buf[0].len;
>>> +
>>> +        ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
>>> +        if (i < nbufs - 1) {
>>> +            entry->dma_addr[1] = buf[1].addr;
>>> +            entry->dma_len[1] = buf[1].len;
>>> +            buf1 = buf[1].addr;
>>> +            ctrl |= FIELD_PREP(MT_DMA_CTL_SD_LEN1, buf[1].len);
>>> +            if (buf[1].skip_unmap)
>>> +                entry->skip_buf1 = true;
>>>          }
>>>  
>>> +        if (i == nbufs - 1)
>>> +            ctrl |= MT_DMA_CTL_LAST_SEC0;
>>> +        else if (i == nbufs - 2)
>>> +            ctrl |= MT_DMA_CTL_LAST_SEC1;
>>> +
>>>          WRITE_ONCE(desc->buf0, cpu_to_le32(buf0));
>>>          WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
>>>          WRITE_ONCE(desc->info, cpu_to_le32(info));
>>>          WRITE_ONCE(desc->ctrl, cpu_to_le32(ctrl));
>>>  
>>> +        q->head = next;
>>>          q->queued++;
>>>      }
>>>  
>>> @@ -577,17 +609,9 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct
>>> mt76_queue *q)
>>>      spin_lock_bh(&q->lock);
>>>  
>>>      while (q->queued < q->ndesc - 1) {
>>> -        struct mt76_txwi_cache *t = NULL;
>>>          struct mt76_queue_buf qbuf;
>>>          void *buf = NULL;
>>>  
>>> -        if ((q->flags & MT_QFLAG_WED) &&
>>> -            FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX) {
>>> -            t = mt76_get_rxwi(dev);
>>> -            if (!t)
>>> -                break;
>>> -        }
>>> -
>>>          buf = page_frag_alloc(rx_page, q->buf_size, GFP_ATOMIC);
>>>          if (!buf)
>>>              break;
>>> @@ -601,7 +625,12 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct
>>> mt76_queue *q)
>>>          qbuf.addr = addr + offset;
>>>          qbuf.len = len - offset;
>>>          qbuf.skip_unmap = false;
>>> -        mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t);
>>> +        if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {
>>> +            dma_unmap_single(dev->dma_dev, addr, len,
>>> +                     DMA_FROM_DEVICE);
>>> +            skb_free_frag(buf);
>>> +            break;
>>> +        }
>>>          frames++;
>>>      }
>>>  
>>>
>>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
>>> @@ -653,6 +653,13 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct
>>> mtk_wed_device *wed, int size)
>>>  
>>>          desc->buf0 = cpu_to_le32(phy_addr);
>>>          token = mt76_rx_token_consume(&dev->mt76, ptr, t, phy_addr);
>>> +        if (token < 0) {
>>> +            dma_unmap_single(dev->mt76.dma_dev, phy_addr,
>>> +                     wed->wlan.rx_size, DMA_TO_DEVICE);
>>> +            skb_free_frag(ptr);
>>> +            goto unmap;
>>> +        }
>>> +
>>>          desc->token |= cpu_to_le32(FIELD_PREP(MT_DMA_CTL_TOKEN,
>>>                                token));
>>>          desc++;
>>>
>>> --- a/drivers/net/wireless/mediatek/mt76/tx.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
>>> @@ -764,11 +764,12 @@ int mt76_rx_token_consume(struct mt76_dev *dev,
>>> void *ptr,
>>>      spin_lock_bh(&dev->rx_token_lock);
>>>      token = idr_alloc(&dev->rx_token, t, 0, dev->rx_token_size,
>>>                GFP_ATOMIC);
>>> +    if (token >= 0) {
>>> +        t->ptr = ptr;
>>> +        t->dma_addr = phys;
>>> +    }
>>>      spin_unlock_bh(&dev->rx_token_lock);
>>>  
>>> -    t->ptr = ptr;
>>> -    t->dma_addr = phys;
>>> -
>>>      return token;
>>>  }
>>>  EXPORT_SYMBOL_GPL(mt76_rx_token_consume);
>>>

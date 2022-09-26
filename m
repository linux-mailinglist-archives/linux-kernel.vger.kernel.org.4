Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8285E978D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 02:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiIZAmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 20:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiIZAmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 20:42:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271172C12F;
        Sun, 25 Sep 2022 17:42:00 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fv3so4889216pjb.0;
        Sun, 25 Sep 2022 17:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=O/gG7i1U+ZjLMbqINX8HTYswuyZSqHXOwjFzg71oSbc=;
        b=gBsOuNAAAoAP4S+0LTxcEvnQxDsBOmg5v+zlSym7BYtLhxudi9IaC0MSZdC7sDxNkL
         z/8JcLjpwsiOojNnhwUZE9QrYFnrX8GkMo4DySacVozlP/sk71wEZaemtQ07V3DHiAKF
         l+4KhslVQOPnarmkF0azDoOHXREkgjsfvN5Q3XBXFcPfACVDhviT5bRisZQec2udEQqo
         D0497TFdj7IwT4i3XxGOiI4gxyeoNxbNhT2hbF+j3gxWVkLJKXq4kbx0Rc/2DVsPmdKm
         IHZP6wU8SZIpwwcmbOzZUZIju+EVUWrz2lJYml/JOONXgDM7F0eN38mlF6vW2rHw6wXn
         Sn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=O/gG7i1U+ZjLMbqINX8HTYswuyZSqHXOwjFzg71oSbc=;
        b=vKQDNI20Na3qWQgLeRycdFE/Cs7UO75+kDa2TFme96L4HyYIM+0OENfoYjAokGx3OS
         hgPQjJzDO1y1zsH6mIQK4K6FRwhpRdfQ6OH1kzlAYj5Hmw6veHKOWEzGQOwszd59MWVt
         F/VLMuPj7mTY9B9ah51HWLX8PjeBfW/+RnmZOIJ3V16bDyRmTVg/4VukH3+DaekgtSK9
         X6oe+ppMIZwFgzD62IKhpIVw9AIlxGtLqpAbJLUjMfN+Uc671GgR/T1uU3Rw3OsUBHnr
         bVBS4jG9c3+zj3UlVcdIb5AEE95+JkDyXmzE8PiEeJiUAPf6QbrXLDEEfrFRzlJHof1m
         HfFg==
X-Gm-Message-State: ACrzQf0f8UMmIML9/32twm+bXowllayoHqQSup3sz685yap6jmU0mam5
        GWLaxBGZcSs+YublUYds34oFdr+UxfFfwRGRXqwHmLNoBbFQOvMt
X-Google-Smtp-Source: AMsMyM4w9p1kQ5NDTbmVRdfYXhwtUeiQE64dQc4/xIjas0o+fcpA6tkmvto0+cV7tVWdva5ylUS32VWPwnslYreG1hc=
X-Received: by 2002:a17:902:cecf:b0:178:3b53:ebf5 with SMTP id
 d15-20020a170902cecf00b001783b53ebf5mr19921119plg.122.1664152919181; Sun, 25
 Sep 2022 17:41:59 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 26 Sep 2022 05:41:47 +0500
Message-ID: <CABXGCsP0znm9pS-MiKtyxTXR7XiyFVqen0qzNpicGHDZKCzbwg@mail.gmail.com>
Subject: After commit 44fa75f207d8a106bc75e6230db61e961fdbf8a8 Wi-Fi (mt7921e)
 speed significantly decreased
To:     jelonek.jonas@gmail.com, johannes.berg@intel.com,
        lorenzo.bianconi83@gmail.com, sean.wang@mediatek.com
Cc:     Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
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

Hi!

I bisected the issue and found the first bad commit.

44fa75f207d8a106bc75e6230db61e961fdbf8a8 is the first bad commit
commit 44fa75f207d8a106bc75e6230db61e961fdbf8a8
Author: Jonas Jelonek <jelonek.jonas@gmail.com>
Date:   Mon May 9 19:39:57 2022 +0200

    mac80211: extend current rate control tx status API

    This patch adds the new struct ieee80211_rate_status and replaces
    'struct rate_info *rate' in ieee80211_tx_status with pointer and length
    annotation.

    The struct ieee80211_rate_status allows to:
    (1)     receive tx power status feedback for transmit power control (TPC)
            per packet or packet retry
    (2)     dynamic mapping of wifi chip specific multi-rate retry (mrr)
            chains with different lengths
    (3)     increase the limit of annotatable rate indices to support
            IEEE802.11ac rate sets and beyond

    ieee80211_tx_info, control and status buffer, and ieee80211_tx_rate
    cannot be used to achieve these goals due to fixed size limitations.

    Our new struct contains a struct rate_info to annotate the rate that was
    used, retry count of the rate and tx power. It is intended for all
    information related to RC and TPC that needs to be passed from driver to
    mac80211 and its RC/TPC algorithms like Minstrel_HT. It corresponds to
    one stage in an mrr. Multiple subsequent instances of this struct can be
    included in struct ieee80211_tx_status via a pointer and a length variable.
    Those instances can be allocated on-stack. The former reference to a single
    instance of struct rate_info is replaced with our new annotation.

    An extension is introduced to struct ieee80211_hw. There are two new
    members called 'tx_power_levels' and 'max_txpwr_levels_idx' acting as a
    tx power level table. When a wifi device is registered, the driver shall
    supply all supported power levels in this list. This allows to support
    several quirks like differing power steps in power level ranges or
    alike. TPC can use this for algorithm and thus be designed more abstract
    instead of handling all possible step widths individually.

    Further mandatory changes in status.c, mt76 and ath11k drivers due to the
    removal of 'struct rate_info *rate' are also included.
    status.c already uses the information in ieee80211_tx_status->rate in
    radiotap, this is now changed to use ieee80211_rate_status->rate_idx.
    mt76 driver already uses struct rate_info to pass the tx rate to status
    path. The new members of the ieee80211_tx_status are set to NULL and 0
    because the previously passed rate is not relevant to rate control and
    accurate information is passed via tx_info->status.rates.
    For ath11k, the txrate can be passed via this struct because ath11k uses
    firmware RC and thus the information does not interfere with software RC.

    Compile-Tested: current wireless-next tree with all flags on
    Tested-on: Xiaomi 4A Gigabit (MediaTek MT7603E, MT7612E) with OpenWrt
                    Linux 5.10.113

    Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
    Link: https://lore.kernel.org/r/20220509173958.1398201-2-jelonek.jonas@gmail.com
    Signed-off-by: Johannes Berg <johannes.berg@intel.com>

 drivers/net/wireless/ath/ath11k/dp_tx.c |  8 ++-
 drivers/net/wireless/mediatek/mt76/tx.c |  5 +-
 include/net/mac80211.h                  | 33 +++++++++++-
 net/mac80211/status.c                   | 91 +++++++++++++++++++--------------
 4 files changed, 92 insertions(+), 45 deletions(-)


Before 44fa75f207d8a106bc75e6230db61e961fdbf8a8 speed was:
Idle Latency:     1.86 ms   (jitter: 0.06ms, low: 1.79ms, high: 1.99ms)
    Download:   834.57 Mbps (data used: 698.7 MB)
                 25.53 ms   (jitter: 6.82ms, low: 4.79ms, high: 234.55ms)
      Upload:   818.72 Mbps (data used: 881.9 MB)
                 17.98 ms   (jitter: 5.49ms, low: 4.66ms, high: 53.61ms)

After 44fa75f207d8a106bc75e6230db61e961fdbf8a8 speed became:
Idle Latency:     1.86 ms   (jitter: 0.42ms, low: 1.63ms, high: 2.73ms)
    Download:   546.18 Mbps (data used: 629.1 MB)
                  5.89 ms   (jitter: 1.62ms, low: 2.64ms, high: 22.30ms)
      Upload:   171.69 Mbps (data used: 141.0 MB)
                  3.07 ms   (jitter: 1.06ms, low: 1.79ms, high: 7.98ms)

All measures I made by cli speedtest utility.

Thanks.

-- 
Best Regards,
Mike Gavrilov.

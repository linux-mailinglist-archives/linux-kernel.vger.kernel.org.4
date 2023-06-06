Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE88F7236E8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjFFFis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjFFFip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:38:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B371BB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 22:38:43 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so57129755e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 22:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686029922; x=1688621922;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDoRkFVgtt0ly2lGzEtgXYMPs7j7vOsWoVsKufVaHvE=;
        b=UB+I9tUa5wgLDtVALQwu6H3jyvBYAT006Thc0t/h4JyHa8FUga6YbgdNKCHVsg4Oj5
         PdRB5XFIQAFNwhvT5MzsAySRbOCpcY6zjbXMtDvxgTDYvDtRP+t2WIIINLV8EA7LtD7d
         ln/Bt/8sxEns8sEosBObja9lxoZAUZ6HVMVVPNlLVZIXlkMrKjikqxbjuH16vnD/xcS7
         7S5ZzFd4Tum//oevLXdqhEyJRE6FNKCFusQ33fjTC/E5iSHmF3KGxViI7bXa2kMmzhP+
         zDE5xJi88NHd4ht4yFQ3lchxXh02ImwJ59uGj4J1TIE3EER1KR5B9FCMXEDe2edUinjz
         Bnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686029922; x=1688621922;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDoRkFVgtt0ly2lGzEtgXYMPs7j7vOsWoVsKufVaHvE=;
        b=Y5I72MkoporyO3MQ4xzGVfx2Qkh1e15lbox2L6Z81gWO9RlgcAIBG4ZgxdrcoclNmp
         R68MnSN02KOOg8Y4T6ceC8rKuLfLiEzn87hVzzkok1qWpfI4eAu06m+xF+q4k6KIjxmU
         pyqDOqZKc2fRjJmh0mNCWhJnj4tS989iXjAO1HVrp1xYPw5oMlWSKnhZM30OEoo6caFJ
         bZhlSBUm0vJAhjCmpv1O5vjgakdxI4ZgRJrxEleWT6GJ3gmD/k4zQS9Y6TYN/eT6OH0Y
         OQ2VwxGDgsZMFlOJyuBINzp3vnERd0InAL6FqQiTt7qdMxXQdseFNOVO8HQomTwEanrp
         A3Cg==
X-Gm-Message-State: AC+VfDw/rkznS+s+EUrTZeXuM+l33boQxYqqaLSMrnuH57fTzl25aOT/
        TZXPwzZzRLL3vqAxSakValCbUw==
X-Google-Smtp-Source: ACHHUZ7bdLhwl5ditaWswLjB5bFgSLA8PWLXrRGSz1IgeW6EjXeYMCTKFKQSDzrke6es1xjHZY4+Zg==
X-Received: by 2002:a7b:c8d5:0:b0:3f7:e80b:bfc with SMTP id f21-20020a7bc8d5000000b003f7e80b0bfcmr1190300wml.30.1686029921841;
        Mon, 05 Jun 2023 22:38:41 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g11-20020a7bc4cb000000b003f735ba7736sm8056670wmk.46.2023.06.05.22.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:38:40 -0700 (PDT)
Date:   Tue, 6 Jun 2023 08:38:37 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Felix Fietkau <nbd@nbd.name>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: drivers/net/wireless/mediatek/mt76/mt76x02_util.c:475
 mt76x02_set_key() warn: variable dereferenced before check 'key' (see line
 415)
Message-ID: <2f121202-5846-44a9-8b83-e2ba1fa671d0@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f8dba31b0a826e691949cd4fdfa5c30defaac8c5
commit: e6db67fa871dee37d22701daba806bfcd4d9df49 wifi: mt76: ignore key disable commands
config: riscv-randconfig-m031-20230605 (https://download.01.org/0day-ci/archive/20230606/202306060332.WbIToDHL-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202306060332.WbIToDHL-lkp@intel.com/

smatch warnings:
drivers/net/wireless/mediatek/mt76/mt76x02_util.c:475 mt76x02_set_key() warn: variable dereferenced before check 'key' (see line 415)

vim +/key +475 drivers/net/wireless/mediatek/mt76/mt76x02_util.c

60c26859e863c1 Stanislaw Gruszka 2018-09-04  407  int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
60c26859e863c1 Stanislaw Gruszka 2018-09-04  408  		    struct ieee80211_vif *vif, struct ieee80211_sta *sta,
60c26859e863c1 Stanislaw Gruszka 2018-09-04  409  		    struct ieee80211_key_conf *key)
60c26859e863c1 Stanislaw Gruszka 2018-09-04  410  {
d87cf75f111183 Lorenzo Bianconi  2018-10-07  411  	struct mt76x02_dev *dev = hw->priv;
60c26859e863c1 Stanislaw Gruszka 2018-09-04  412  	struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
60c26859e863c1 Stanislaw Gruszka 2018-09-04  413  	struct mt76x02_sta *msta;
60c26859e863c1 Stanislaw Gruszka 2018-09-04  414  	struct mt76_wcid *wcid;
60c26859e863c1 Stanislaw Gruszka 2018-09-04 @415  	int idx = key->keyidx;

"key" is dereferenced here

60c26859e863c1 Stanislaw Gruszka 2018-09-04  416  	int ret;
60c26859e863c1 Stanislaw Gruszka 2018-09-04  417  
60c26859e863c1 Stanislaw Gruszka 2018-09-04  418  	/* fall back to sw encryption for unsupported ciphers */
60c26859e863c1 Stanislaw Gruszka 2018-09-04  419  	switch (key->cipher) {
60c26859e863c1 Stanislaw Gruszka 2018-09-04  420  	case WLAN_CIPHER_SUITE_WEP40:
60c26859e863c1 Stanislaw Gruszka 2018-09-04  421  	case WLAN_CIPHER_SUITE_WEP104:
60c26859e863c1 Stanislaw Gruszka 2018-09-04  422  	case WLAN_CIPHER_SUITE_TKIP:
60c26859e863c1 Stanislaw Gruszka 2018-09-04  423  	case WLAN_CIPHER_SUITE_CCMP:
60c26859e863c1 Stanislaw Gruszka 2018-09-04  424  		break;
60c26859e863c1 Stanislaw Gruszka 2018-09-04  425  	default:
60c26859e863c1 Stanislaw Gruszka 2018-09-04  426  		return -EOPNOTSUPP;
60c26859e863c1 Stanislaw Gruszka 2018-09-04  427  	}
60c26859e863c1 Stanislaw Gruszka 2018-09-04  428  
60c26859e863c1 Stanislaw Gruszka 2018-09-04  429  	/*
60c26859e863c1 Stanislaw Gruszka 2018-09-04  430  	 * The hardware does not support per-STA RX GTK, fall back
60c26859e863c1 Stanislaw Gruszka 2018-09-04  431  	 * to software mode for these.
60c26859e863c1 Stanislaw Gruszka 2018-09-04  432  	 */
60c26859e863c1 Stanislaw Gruszka 2018-09-04  433  	if ((vif->type == NL80211_IFTYPE_ADHOC ||
60c26859e863c1 Stanislaw Gruszka 2018-09-04  434  	     vif->type == NL80211_IFTYPE_MESH_POINT) &&
60c26859e863c1 Stanislaw Gruszka 2018-09-04  435  	    (key->cipher == WLAN_CIPHER_SUITE_TKIP ||
60c26859e863c1 Stanislaw Gruszka 2018-09-04  436  	     key->cipher == WLAN_CIPHER_SUITE_CCMP) &&
60c26859e863c1 Stanislaw Gruszka 2018-09-04  437  	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
60c26859e863c1 Stanislaw Gruszka 2018-09-04  438  		return -EOPNOTSUPP;
60c26859e863c1 Stanislaw Gruszka 2018-09-04  439  
b98558e2529986 Stanislaw Gruszka 2019-03-19  440  	/*
b98558e2529986 Stanislaw Gruszka 2019-03-19  441  	 * In USB AP mode, broadcast/multicast frames are setup in beacon
b98558e2529986 Stanislaw Gruszka 2019-03-19  442  	 * data registers and sent via HW beacons engine, they require to
b98558e2529986 Stanislaw Gruszka 2019-03-19  443  	 * be already encrypted.
b98558e2529986 Stanislaw Gruszka 2019-03-19  444  	 */
61c51a74a4e586 Lorenzo Bianconi  2019-10-29  445  	if (mt76_is_usb(&dev->mt76) &&
b98558e2529986 Stanislaw Gruszka 2019-03-19  446  	    vif->type == NL80211_IFTYPE_AP &&
b98558e2529986 Stanislaw Gruszka 2019-03-19  447  	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
b98558e2529986 Stanislaw Gruszka 2019-03-19  448  		return -EOPNOTSUPP;
b98558e2529986 Stanislaw Gruszka 2019-03-19  449  
4b36cc6b390f18 David Bauer       2021-02-07  450  	/* MT76x0 GTK offloading does not work with more than one VIF */
4b36cc6b390f18 David Bauer       2021-02-07  451  	if (is_mt76x0(dev) && !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
4b36cc6b390f18 David Bauer       2021-02-07  452  		return -EOPNOTSUPP;
4b36cc6b390f18 David Bauer       2021-02-07  453  
60c26859e863c1 Stanislaw Gruszka 2018-09-04  454  	msta = sta ? (struct mt76x02_sta *)sta->drv_priv : NULL;
60c26859e863c1 Stanislaw Gruszka 2018-09-04  455  	wcid = msta ? &msta->wcid : &mvif->group_wcid;
60c26859e863c1 Stanislaw Gruszka 2018-09-04  456  
e6db67fa871dee Felix Fietkau     2023-03-30  457  	if (cmd != SET_KEY) {
60c26859e863c1 Stanislaw Gruszka 2018-09-04  458  		if (idx == wcid->hw_key_idx) {
60c26859e863c1 Stanislaw Gruszka 2018-09-04  459  			wcid->hw_key_idx = -1;
f2f6a47b504b8f Felix Fietkau     2019-01-25  460  			wcid->sw_iv = false;
60c26859e863c1 Stanislaw Gruszka 2018-09-04  461  		}
60c26859e863c1 Stanislaw Gruszka 2018-09-04  462  
e6db67fa871dee Felix Fietkau     2023-03-30  463  		return 0;
e6db67fa871dee Felix Fietkau     2023-03-30  464  	}
e6db67fa871dee Felix Fietkau     2023-03-30  465  
e6db67fa871dee Felix Fietkau     2023-03-30  466  	key->hw_key_idx = wcid->idx;
e6db67fa871dee Felix Fietkau     2023-03-30  467  	wcid->hw_key_idx = idx;
e6db67fa871dee Felix Fietkau     2023-03-30  468  	if (key->flags & IEEE80211_KEY_FLAG_RX_MGMT) {
e6db67fa871dee Felix Fietkau     2023-03-30  469  		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
e6db67fa871dee Felix Fietkau     2023-03-30  470  		wcid->sw_iv = true;
60c26859e863c1 Stanislaw Gruszka 2018-09-04  471  	}
d87cf75f111183 Lorenzo Bianconi  2018-10-07  472  	mt76_wcid_key_setup(&dev->mt76, wcid, key);
60c26859e863c1 Stanislaw Gruszka 2018-09-04  473  
60c26859e863c1 Stanislaw Gruszka 2018-09-04  474  	if (!msta) {
60c26859e863c1 Stanislaw Gruszka 2018-09-04 @475  		if (key || wcid->hw_key_idx == idx) {

This NULL check is too late.

8d66af49a3db9a Lorenzo Bianconi  2018-10-07  476  			ret = mt76x02_mac_wcid_set_key(dev, wcid->idx, key);
60c26859e863c1 Stanislaw Gruszka 2018-09-04  477  			if (ret)
60c26859e863c1 Stanislaw Gruszka 2018-09-04  478  				return ret;
60c26859e863c1 Stanislaw Gruszka 2018-09-04  479  		}
60c26859e863c1 Stanislaw Gruszka 2018-09-04  480  
8d66af49a3db9a Lorenzo Bianconi  2018-10-07  481  		return mt76x02_mac_shared_key_setup(dev, mvif->idx, idx, key);
60c26859e863c1 Stanislaw Gruszka 2018-09-04  482  	}
60c26859e863c1 Stanislaw Gruszka 2018-09-04  483  
8d66af49a3db9a Lorenzo Bianconi  2018-10-07  484  	return mt76x02_mac_wcid_set_key(dev, msta->wcid.idx, key);
60c26859e863c1 Stanislaw Gruszka 2018-09-04  485  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


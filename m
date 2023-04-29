Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C136F269F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 23:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjD2VmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 17:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjD2VmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 17:42:07 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C3C121
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 14:42:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1682804341; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QwHb1hTFsykXuVQdJozKd1MtJV23VkkGwGxiy/NnoUjL9y6ey5FuFmyKO+liU7wx0l
    3c+p6ErXZZWWNYiw1emeojJp3lQPVVbD8G3njudRenZpFgrySykCfdNF2d17S/QKHGR5
    4taa2B5Yc+Vbd94YFUnIme/kbT6AHa0ImBTYE6SWDdj4osu6OxzwQueKnq/ll3KXzRUm
    lLRNfdIWY2fkAJH7UOlZJgwtB9UWOGYzuZrin2z9ql18yrm+g+RLkYYrIwaVpyUe5NHn
    If8+B40u5YU91RRi1lCJJjIO5AaUH9mTxHy7lGG2LWmcyAld8qYVoEf+UimYhgf/jqON
    ju3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1682804341;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:To:References:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=Kajbr5BCcsQN4/m67iumtdEkCEnoM54s5+ArX5MYU74=;
    b=FSBBOMyI4nODEhgLpwVvnbEk2t820+dFySqmL4kx+7d9Q/a7EnH7VL5NDe7Tzk1rxt
    hfXRA2nPYckSuNL/JjTyYTPJH9m3siDW8F6ZIZu3Mi9YiQpX1XqVi3jr7q4UB9IfDk6G
    z5QQz0kV/7XozxELnO8Mzl0pIAnbwHWk1tBP3EPTpP60Mn8/YmXCVHlgRV9NcUEbNV4G
    ouJAzqRknnRQBmt7Rl1TrgkbCz5KTZePC67Ux9juEPKG+GZxbWTRipcNpDj/fbkzkAJ/
    zEvIO0xNwsP0fTLjtKS/BZD1WL4K4R6u7Dq4A6rD+tBjx4e/ynxO/kbrgevumII9Rzki
    lnww==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1682804341;
    s=strato-dkim-0002; d=garloff.de;
    h=In-Reply-To:From:To:References:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=Kajbr5BCcsQN4/m67iumtdEkCEnoM54s5+ArX5MYU74=;
    b=W5whW4YsULsaYrJ9gQNwC4kPxGnIubKzE/1ZL8Wb0lBg9Q7yCdNdvcT2vRjuWwzMRA
    v0tr4nGcgqffzes+/QQ4d1EMu9rhCDPBDh/ErHItYu99YzmuGEIc5DU1prl/Ij/+WQRv
    jmes3GAVMxeIjxJI4NrCGWZdlbyTQJzmHTSyfC0eEi7EF/InNZuetkq+lEiePau6ldEb
    M2E3fxsGet6Hmp9mwQSdpXGYjOLbqg+O9ci+koiwhrro6PLF3uyod0qMT8JhJdDaW4Dw
    TnRI9zpPN4pffY+0x27aByXCyYKhvgI8J8HhgWlCFVmPfZYYanbzl1vh1LFiJjukzsdy
    hNVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1682804341;
    s=strato-dkim-0003; d=garloff.de;
    h=In-Reply-To:From:To:References:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=Kajbr5BCcsQN4/m67iumtdEkCEnoM54s5+ArX5MYU74=;
    b=BpFUF2BjQHURsw9JT5+6qNReStxXNLUUIPTZ7ZSIje+dWFwchaqf++cGsBuSQy2l+Y
    2BsAIw3EZGpmqgqKrvAA==
X-RZG-AUTH: ":J3kWYWCveu3U88BfwGxYwcN+YZ41GOdzWdTW9IJoHV1zocjVWQ2HeUTsAyii+DCqbRq0"
Received: from mail.garloff.de
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id D69cfaz3TLd0VNf
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 29 Apr 2023 23:39:00 +0200 (CEST)
Received: from [192.168.155.218] (ap5.garloff.de [192.168.155.10])
        by mail.garloff.de (Postfix) with ESMTPSA id 52DBA5FF5A;
        Sat, 29 Apr 2023 23:39:00 +0200 (CEST)
Message-ID: <fce7ea8d-d89c-daf0-f900-d26455d1bb74@garloff.de>
Date:   Sat, 29 Apr 2023 23:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Fwd: 6.1.23: 0fc6fea41c71 breaks GPD Pocket 3 modeset
Content-Language: en-US
References: <4115dc28-45b6-cad1-1e38-39e5a0484a8a@garloff.de>
To:     LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
From:   Kurt Garloff <kurt@garloff.de>
In-Reply-To: <4115dc28-45b6-cad1-1e38-39e5a0484a8a@garloff.de>
X-Forwarded-Message-Id: <4115dc28-45b6-cad1-1e38-39e5a0484a8a@garloff.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville,

(sorry for the resend, had forgotten that LKML still believes
that multipart with an HTML version is evil)

While
0fc6fea41c71 drm/i915: Disable DC states for all commits
(cherry picked from commit 41b4c7fe72b6105a4b49395eea9aa40cef94288d)
does look correct to me, it does break modesetting on the
GPD Pocket 3, a i7-1195G7 laptop. I run the kernel with
fbcon=rotate:1 video=DSI-1:panel_orientation=right_side_up \
   mem_sleep_default=s2idle
No special i915 parameters.

Hardware is described here:
https://wiki.archlinux.org/title/GPD_Pocket_3

I disected this patch which was merged (backported) for 6.1.23.
I currently run 6.1.26 with it reverted and life is good.

Without reverting it, when fbcon is switched to show the splash
screen (GPD logo with Ubuntu added in on working kernels), the
screen remains black (backlight on, but nothing displayed) and
nothing happens any more. It looks like something more serious
than just blackness, as SysRq or Ctrl-Alt-Del don't do anything.
Deadlocking?

Best,

-- 

Kurt Garloff<kurt@garloff.de>
Cologne, Germany


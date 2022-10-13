Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C335FD5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 09:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJMHwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 03:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJMHw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 03:52:29 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C1112D819
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 00:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665647549; x=1697183549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nrhVsbzNcy1sQd2FmHuxrZcMS3UkNIcfyGdPZvyiupY=;
  b=Fvvn8Nt8F5qiScIbNmouTyby4EtKOE2Mr9K/j+DEzMclePtgCqr8Gg4Q
   d84v3vaKKnbh+kRA3+VfRFOLjXB8Na4tERM4fsYZ9k6x+Bi++Pvs9QzMm
   o6SaNtN10Zsj9DEB87iMZU0bOkNCE3l4X3JomcaugzLlePDLifLmPuFNf
   0/V3ImApoBMQSq6IuAhyq7YiIxqGAqNTBGBSA5GzoAGAJUVqAnlq1CNHq
   y+eu7SsbZ9Rq0sJGAfNNPL6tK3SCDu8TqFxwT/fNFqj+ciESanfHJVeE1
   Ke9e5b/5ivi71V38lVaFv9GQ++1Qf2biy1s/gfPi/MAlW+Vhy8imjFtCU
   A==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661788800"; 
   d="scan'208";a="214076278"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2022 15:52:27 +0800
IronPort-SDR: Oa6qJ2EzqtByBAserhpqdWnSloBQPzGttyvGzK029lirQAMSVZxs7mRNeJh6hLAvhIs9V10Mpr
 neEifLYg2U4nzyoW7sv2GrEldk2IRjEYlIykJyD2CoAePisIqwDnWxuieEvXRvRbuVeW7qq5ke
 +r8xKnqkPY4NRzuOIJV59f450sYwLfI1Csjlai0qhwFEaV9uXlkuSFFMEMcZeJDbTvuYLCvtXn
 lQ2gBUJckTOem3tWw5LdWBEo91rEoj9gYHlxldutUyescOEMXkjy5ANDChypR06aDgeGbZru0r
 NAxdgSPSxOH5hpfa6W33FLZK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2022 00:06:28 -0700
IronPort-SDR: WMIoJSncpV3bO9bNdyp3wAFrF3afi8dJHwif1hsQyZmJG7LRDjQcDhabOhG1/nDEvGwYZkqu3d
 lid86KOXIcxXnAGK3Aj5RGz6ZYA9MK8oe0ZL/nn8pEaevupF5cMSeVioZGWtg+ouze7bF+ymLa
 aCCBK07HDUemRsXdfXIMpiUn29A+B4tVpV6yRIjSdGBWkTsAdeqCCLjeu6eg+ny3n2Qp/I0n/l
 4TCChrxH8zglrXW+26+APcGuwe44doyIAuw6thmtrd+AVHNnjEv73JYqaZ3SbSlK+ZAcd++mcZ
 u4M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2022 00:52:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mp1vb1lFlz1Rwrq
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 00:52:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665647546; x=1668239547; bh=nrhVsbzNcy1sQd2FmHuxrZcMS3UkNIcfyGd
        PZvyiupY=; b=IkpTS4GuokEGDuIzWvWWHIAvtI1fkqfWqi4IVL0jD0Zxxtw5R0I
        FlQm5M4q4AIlCb6JUh6oivWu2einzxVH1iJOl99DQrQN5tvBc7cp2rIlidbrWFmz
        ilHMJUoT+luIJosCUckIDw3mRFIPoe026WX3f6b+H4TY9Lg+CtxPizC8Ts4wbAAY
        JN8sSDVVOYoz9Xs0om8Fl84hHAjks4OzuH4ijidQcui9dM431cRjnanzun0D1mry
        CEsBw1ddIpp50fsSrcfzNjOlGnqR9bxcuPPwgIs+9274aptd4lM85MxwpKAEkz1T
        2By+UfDp6vgGw0fGo9jw+Km3uXBHhC7RdeQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J8ev4QmjBkWn for <linux-kernel@vger.kernel.org>;
        Thu, 13 Oct 2022 00:52:26 -0700 (PDT)
Received: from [10.89.85.169] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.169])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mp1vY6CrXz1RvLy;
        Thu, 13 Oct 2022 00:52:25 -0700 (PDT)
Message-ID: <035b7855-b6fc-5604-7969-7b356ffa33e3@opensource.wdc.com>
Date:   Thu, 13 Oct 2022 16:52:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH 4.19] scsi: sd: Fix 'sdkp' in sd_first_printk
Content-Language: en-US
To:     Li kunyu <kunyu@nfschina.com>, yanaijie@huawei.com
Cc:     jejb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com
References: <badf255f-df60-fbc7-0f61-c69b99ebbaa6@huawei.com>
 <20221013073920.279180-1-kunyu@nfschina.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221013073920.279180-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/13 16:39, Li kunyu wrote:
> 
> Hello, I'm not sure how to operate it. Do you want to execute git push to submit this patch in branch 4.19.
> 
> thanks,
> kunyu
> 

Please see Documentation/process/stable-kernel-rules.rst for how to proceed. In
this case, I think you should follow "option 2", but read the entire document to
understand all cases.

-- 
Damien Le Moal
Western Digital Research


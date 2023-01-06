Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A38660A7F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbjAFX5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjAFX5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:57:36 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0EA7CDFF;
        Fri,  6 Jan 2023 15:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673049454; x=1704585454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3d1DO0cDsSSFGxEy7xYujqdO/RXqj/Yc3KB9N5fpqDU=;
  b=OmDQz8Ojbhii214FsWYPvwR8Wgq2GiiwUv6z8FnA1Z9BpUbf/VdumxbU
   2gqlreDE8fN1+svoiclvs7ovo8AMSDbC3Ab89JEj1uckulFtdLKBgdEtv
   H53pr0GoncpJTkB/DB7Bqpo1YnYJIFFU8veqFQG2c0q54PPQJp2fkQXWg
   6IdMfYCJcK89SXhd0qg4c2EtHWMnnSQELc10SvkscCl2TOQZlGjb7ct0N
   gjZUUeOU85wJKksaTEL3FghiO65ylbxYEpc8jFX3NS314G/e5c5neUKcc
   p/imfVDFkWWIsyCCfTwdkSGykL9FoFopKOLAV/5SrzAnom6ZjNj+WlIzI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="387047041"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="387047041"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 15:57:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="984817951"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="984817951"
Received: from apbaezbo-mobl2.amr.corp.intel.com (HELO [10.212.60.153]) ([10.212.60.153])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 15:57:32 -0800
Message-ID: <654077f4-2ae2-3457-b777-9eb3b816c6ba@linux.intel.com>
Date:   Fri, 6 Jan 2023 10:16:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 03/14] ASoC: qcom: Add USB backend ASoC driver for Q6
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-4-quic_wcheng@quicinc.com>
 <e29060b1-df65-c0d1-5777-023879a5863e@linux.intel.com>
 <0f903c49-a989-14a6-bac1-c4cae21839eb@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <0f903c49-a989-14a6-bac1-c4cae21839eb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/23 19:05, Wesley Cheng wrote:
> Hi Pierre,
> 
> On 1/4/2023 3:41 PM, Pierre-Louis Bossart wrote:
>>
>>> +int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
>>> +            int connected)
>>> +{
>>> +    struct snd_soc_dapm_context *dapm;
>>> +    struct q6usb_port_data *data;
>>> +
>>> +    if (!usb->component)
>>> +        return 0;
>>> +
>>> +    dapm = snd_soc_component_get_dapm(usb->component);
>>> +    data = dev_get_drvdata(usb->component->dev);
>>> +
>>> +    if (connected) {
>>> +        snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
>>> +        /* We only track the latest USB headset plugged in */
>>
>> that answers to my earlier question on how to deal with multiple
>> devices, but is this a desirable policy? This could lead to a lot of
>> confusion. If there are restrictions to a single device, then it might
>> be more interesting for userspace or the user to indicate which USB
>> device gets to use USB offload and all others use legacy.
>>
> 
> Yeah, as mentioned its still pretty open ended.  I think from the
> feedback received from Mark/Takashi, this was a viable option for now.
> Would you happen to have any insight/input on how the userspace can pass
> down that selection to the ASoC framework?  Maybe some kind of PCM IOCTL
> call?

I don't have a turn-key solution either :-)
We'd need userspace to make one device as 'preferred' or 'optimized' and
give it a priority somehow. It can't be a PCM IOCTL, it has to be at the
device level.

It's really a second-level optimization that can be parked for now, the
bulk of the work is really the interaction between USB audio and ASoC
stacks, we should probably focus on that BIG topic with a design that
can be shared across implementations.

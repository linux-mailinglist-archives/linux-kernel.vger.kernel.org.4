Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577DD69E559
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjBUQ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjBUQ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:59:01 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8702364D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676998739; x=1708534739;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iFyDvz2P2otJwQT54nKL7jYUo8yfpArBbDhv6LjMnWo=;
  b=VLGRUz4MUKzzd2H/6DYGtepGhl/QvwknQBcGrFCY2c/F4U7KykGWazft
   KfSO1VzXCgkiAQMAGc94RxnPhDBMSpySU/HsZGm1zf12hJEg+NHq429ot
   /3bN5EB0FzH2XZNYJsbsw38ke69COcDm/Tdun7Lrz9ubujodbvTgQCO0W
   5TuOV/V5+Np6QvzNnXXbPuBJjbCsxxSAs8vn+2+mvktLbr/zdCiEQYA5N
   WZqwqwOui7DRr81pQ7x0+aAdgZSH/3j+QPRl8JdaYrbNCTCpmSjNWqQSt
   Vjb/06HLGSiJn+ia5lwu+llSewSet1eIjS2XRPxx8qYl2jmLfCFsZwtAc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334884760"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="334884760"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="814569146"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="814569146"
Received: from taevough-mobl.amr.corp.intel.com (HELO [10.209.174.213]) ([10.209.174.213])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:47 -0800
Message-ID: <20097f1d-a7ef-9932-685c-afb22006076c@linux.intel.com>
Date:   Tue, 21 Feb 2023 11:52:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 10/10] ASoC: Intel: soc-acpi: Add CS35L56 Soundwire to TGL
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
        cezary.rojewski@intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, kai.vehmanen@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230217161410.915202-1-rf@opensource.cirrus.com>
 <20230217161410.915202-11-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230217161410.915202-11-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static const struct snd_soc_acpi_link_adr up_extreme_cs35l56_sdw0_one[] = {
> +	{
> +		.mask = BIT(0),
> +		.num_adr = 1,
> +		.adr_d = cs35l56_sdw0_adr,
> +	},
> +	{}
> +};
> +
> +static const struct snd_soc_acpi_link_adr up_extreme_cs35l56_sdw0_four[] = {
> +	{
> +		.mask = BIT(0),
> +		.num_adr = 4,
> +		.adr_d = cs35l56_sdw0_adr,
> +	},
> +	{}
> +};

If the machine driver has support for the 2-amplifier configuration,
shouldn't it be present here as well?

> +
>  /* this table is used when there is no I2S codec present */
>  struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_sdw_machines[] = {
>  	/* mockup tests need to be first */
> @@ -501,6 +546,18 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_sdw_machines[] = {
>  		.drv_name = "sof_sdw",
>  		.sof_tplg_filename = "sof-tgl-rt711.tplg",
>  	},
> +	{
> +		.link_mask = BIT(0),
> +		.links = up_extreme_cs35l56_sdw0_four,
> +		.drv_name = "sof_sdw",
> +		.sof_tplg_filename = "sof-tgl-cs35l56-sdw0.tplg"
> +	},
> +	{
> +		.link_mask = BIT(0),
> +		.links = up_extreme_cs35l56_sdw0_one,
> +		.drv_name = "sof_sdw",
> +		.sof_tplg_filename = "sof-tgl-cs35l56-sdw0.tplg"
> +	},
>  	{},
>  };
>  EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_tgl_sdw_machines);

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC0F65E134
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjADX7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjADX7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:59:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCFF4318D;
        Wed,  4 Jan 2023 15:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672876755; x=1704412755;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DZgBOwyaksYR8rOqarCeAE7wIzcUZnoEzEaWzuWNeE8=;
  b=KUR1u8aW+AWVPqeBmRv3LPrUj5qtTnpm8kNBiZ5hUMR2Zj6lqRWIlr1O
   gB5pzSATErNuaPEQsVDK4KFASwZjrmV+h8CpwxmSHRvVj3ownLMVliymC
   vkIV7TuL+RaOylkurCY9QifYtO4ezw2SLtS5Cxqzm7vAR9dy+50o6iC+I
   KOuVUaVXMCZYvMRTuNTTJCRyGiQjzQ6F9bgxil/uANKoBr028gFN2yQ/t
   0GBq4+oK0ZuVnCMpp70v6HYXuE6Xm7hl9XAqM60odp6S7xTszvDJl7VEe
   +46rqiG77B9SBHmKT47mFrpD+ezhlXBNoogJp3frqf6YaZ7hyQN7pq0ld
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="323306066"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="323306066"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 15:58:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="900745331"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="900745331"
Received: from kvthalli-mobl1.amr.corp.intel.com (HELO [10.212.102.90]) ([10.212.102.90])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 15:58:47 -0800
Message-ID: <5babccd6-9796-7613-cf82-cc859f338448@linux.intel.com>
Date:   Wed, 4 Jan 2023 17:33:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 02/14] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
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
 <20221223233200.26089-3-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221223233200.26089-3-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/23/22 17:31, Wesley Cheng wrote:
> The QC ADSP is able to support USB playback and capture, so that the
> main application processor can be placed into lower CPU power modes.  This
> adds the required AFE port configurations and port start command to start
> an audio session.

It would be good to clarify what sort of endpoints can be supported. I
presume the SOF-synchronous case is handled, but how would you deal with
async endpoints with feedback (be it explicit or implicit)?

Note that it's very hard to make the decision not to support async
endpoints, there are quite a few devices that are exposed as async to
work around an obscure legacy issue on Windows but are really
sof-synchronous endpoints that never ask for any change of pace.

> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  .../sound/qcom,q6dsp-lpass-ports.h            |   1 +
>  sound/soc/qcom/qdsp6/q6afe-dai.c              |  47 +++++
>  sound/soc/qcom/qdsp6/q6afe.c                  | 183 ++++++++++++++++++
>  sound/soc/qcom/qdsp6/q6afe.h                  |  46 ++++-
>  sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c      |  23 +++
>  sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h      |   1 +
>  sound/soc/qcom/qdsp6/q6routing.c              |   8 +
>  7 files changed, 308 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
> index 9f7c5103bc82..746bc462bb2e 100644
> --- a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
> +++ b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
> @@ -131,6 +131,7 @@
>  #define RX_CODEC_DMA_RX_7	126
>  #define QUINARY_MI2S_RX		127
>  #define QUINARY_MI2S_TX		128
> +#define USB_RX				129

the commit message says the DSP can support Playback and capture, but
here there's capture only ...


>  
>  static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
> +	{"USB Playback", NULL, "USB_RX"},

... but here RX means playback?

I am not sure I get the convention on directions and what is actually
supported?

> +struct afe_param_id_usb_cfg {
> +/* Minor version used for tracking USB audio device configuration.
> + * Supported values: AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
> + */
> +	u32                  cfg_minor_version;
> +/* Sampling rate of the port.
> + * Supported values:
> + * - AFE_PORT_SAMPLE_RATE_8K
> + * - AFE_PORT_SAMPLE_RATE_11025
> + * - AFE_PORT_SAMPLE_RATE_12K
> + * - AFE_PORT_SAMPLE_RATE_16K
> + * - AFE_PORT_SAMPLE_RATE_22050
> + * - AFE_PORT_SAMPLE_RATE_24K
> + * - AFE_PORT_SAMPLE_RATE_32K
> + * - AFE_PORT_SAMPLE_RATE_44P1K
> + * - AFE_PORT_SAMPLE_RATE_48K
> + * - AFE_PORT_SAMPLE_RATE_96K
> + * - AFE_PORT_SAMPLE_RATE_192K
> + */
> +	u32                  sample_rate;
> +/* Bit width of the sample.
> + * Supported values: 16, 24
> + */
> +	u16                  bit_width;
> +/* Number of channels.
> + * Supported values: 1 and 2

that aligns with my feedback on the cover letter, if you connect a
device that can support from than 2 channels should the DSP even expose
this DSP-optimized path?

Oh and I forgot, what happens if there are multiple audio devices
connected, can the DSP deal with all of them? If not, how is this handled?

> + */
> +	u16                  num_channels;
> +/* Data format supported by the USB. The supported value is
> + * 0 (#AFE_USB_AUDIO_DATA_FORMAT_LINEAR_PCM).
> + */
> +	u16                  data_format;
> +/* this field must be 0 */
> +	u16                  reserved;
> +/* device token of actual end USB aduio device */

typo: audio

> +	u32                  dev_token;
> +/* endianness of this interface */
> +	u32                   endian;

Is this a USB concept? I can't recall having seen any parts of the USB
audio class spec that the data can be big or little endian?

> +/* service interval */
> +	u32                  service_interval;
> +} __packed;

> +int afe_port_send_usb_dev_param(struct q6afe_port *port, struct q6afe_usb_cfg *cfg)
> +{
> +	union afe_port_config *pcfg = &port->port_cfg;
> +	struct afe_param_id_usb_audio_dev_params usb_dev;
> +	struct afe_param_id_usb_audio_dev_lpcm_fmt lpcm_fmt;
> +	struct afe_param_id_usb_audio_svc_interval svc_int;
> +	int ret = 0;
> +
> +	if (!pcfg) {
> +		pr_err("%s: Error, no configuration data\n", __func__);

can you use a dev_err() here and the rest of the code?

> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	memset(&usb_dev, 0, sizeof(usb_dev));
> +	memset(&lpcm_fmt, 0, sizeof(lpcm_fmt));
> +
> +	usb_dev.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
> +	q6afe_port_set_param_v2(port, &usb_dev,
> +					AFE_PARAM_ID_USB_AUDIO_DEV_PARAMS,
> +					AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(usb_dev));
> +	if (ret) {
> +		pr_err("%s: AFE device param cmd failed %d\n",
> +			__func__, ret);
> +		goto exit;
> +	}
> +
> +	lpcm_fmt.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
> +	lpcm_fmt.endian = pcfg->usb_cfg.endian;
> +	ret = q6afe_port_set_param_v2(port, &lpcm_fmt,
> +					AFE_PARAM_ID_USB_AUDIO_DEV_LPCM_FMT,
> +					AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(lpcm_fmt));
> +	if (ret) {
> +		pr_err("%s: AFE device param cmd LPCM_FMT failed %d\n",
> +			__func__, ret);
> +		goto exit;
> +	}
> +
> +	svc_int.cfg_minor_version =
> +		AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
> +	svc_int.svc_interval = pcfg->usb_cfg.service_interval;
> +	ret = q6afe_port_set_param_v2(port, &svc_int,
> +					AFE_PARAM_ID_USB_AUDIO_SVC_INTERVAL,
> +					AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(svc_int));
> +	if (ret) {
> +		pr_err("%s: AFE device param cmd svc_interval failed %d\n",
> +			__func__, ret);
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +exit:
> +	return ret;
> +}

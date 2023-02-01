Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E046869F2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjBAPUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjBAPTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:19:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F019C14F;
        Wed,  1 Feb 2023 07:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675264765; x=1706800765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bya2bwfL249v1sNpczAShDDQseCz+uJqoT8yJ25i2ko=;
  b=GjdL8lYIvN1jgFfe/SLtl5RtPdRFsJyhYtsCow/A6CxEnpCilHXJXukz
   EAztGuvdGLic8mAtfno3Q+WDe033zHH3BlM9L9vItL0nqQ9/An1YLWbiI
   jk1PJvLMLDcaPreNOWErYw6pskNMkFkS2EqkXqO9X+/OtNAKgiEFpdUxj
   tv9QPwEXL+BNARH/isL2HpZ8kIq7Bn+lwFLnVSCaJNd5JVGZZl17KQsEH
   RCPfbBH+/7fGQT2U7fJE1EGJ+hXo8+dCOb1ShWiKVjky62LD0FiHBqwlo
   FEfcsp0jJIUc1KI5C8h/ZEOtnPJ8dlMC6pITpilG789qKuDrI4ih3OzRh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355502930"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="355502930"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 07:18:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="642457124"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="642457124"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Feb 2023 07:18:31 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNEsY-0005Wv-1m;
        Wed, 01 Feb 2023 15:18:30 +0000
Date:   Wed, 1 Feb 2023 23:18:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: Re: [PATCH 04/14] ASoC: q6dsp: audioreach: Add support for compress
 offload commands
Message-ID: <202302012309.BtyJn8FN-lkp@intel.com>
References: <20230201134947.1638197-5-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201134947.1638197-5-quic_mohs@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mohammad,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on next-20230201]
[cannot apply to tiwai-sound/for-next tiwai-sound/for-linus linus/master v6.2-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mohammad-Rafi-Shaik/ALSA-compress-Update-compress-set-params-for-gapless-playback/20230201-215622
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230201134947.1638197-5-quic_mohs%40quicinc.com
patch subject: [PATCH 04/14] ASoC: q6dsp: audioreach: Add support for compress offload commands
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230201/202302012309.BtyJn8FN-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6a2982489303bcf32b927da80e4baffae58437e0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mohammad-Rafi-Shaik/ALSA-compress-Update-compress-set-params-for-gapless-playback/20230201-215622
        git checkout 6a2982489303bcf32b927da80e4baffae58437e0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash sound/soc/qcom/qdsp6/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/qcom/qdsp6/audioreach.c:1262:5: warning: no previous prototype for 'audioreach_send_u32_param' [-Wmissing-prototypes]
    1262 | int audioreach_send_u32_param(struct q6apm *apm, struct audioreach_module *module,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/audioreach_send_u32_param +1262 sound/soc/qcom/qdsp6/audioreach.c

  1261	
> 1262	int audioreach_send_u32_param(struct q6apm *apm, struct audioreach_module *module,
  1263				      uint32_t param_id, uint32_t param_val)
  1264	{
  1265		struct apm_module_param_data *param_data;
  1266		struct gpr_pkt *pkt;
  1267		uint32_t *param;
  1268		int rc, payload_size;
  1269		void *p;
  1270	
  1271		payload_size = sizeof(uint32_t) + APM_MODULE_PARAM_DATA_SIZE;
  1272		p = audioreach_alloc_apm_cmd_pkt(payload_size, APM_CMD_SET_CFG, 0);
  1273		if (IS_ERR(p))
  1274			return -ENOMEM;
  1275	
  1276		pkt = p;
  1277		p = p + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
  1278	
  1279		param_data = p;
  1280		param_data->module_instance_id = module->instance_id;
  1281		param_data->error_code = 0;
  1282		param_data->param_id = param_id;
  1283		param_data->param_size = payload_size - APM_MODULE_PARAM_DATA_SIZE;
  1284	
  1285		p = p + APM_MODULE_PARAM_DATA_SIZE;
  1286		param = p;
  1287		*param = param_val;
  1288		rc = q6apm_send_cmd_sync(apm, pkt, 0);
  1289	
  1290		kfree(pkt);
  1291	
  1292		return rc;
  1293	}
  1294	EXPORT_SYMBOL_GPL(audioreach_send_u32_param);
  1295	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

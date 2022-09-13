Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E719E5B6805
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiIMGkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiIMGjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:39:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1BC10FFE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663051192; x=1694587192;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ytkIShHr4Fxqj6m6LeRVB99UP46NfH9IbAM4YtwiGJc=;
  b=brEngFEDLNW30myPe+Bn163tHIV70FOmvlBUzTVgQ7OR0hyhc55ZJ7h7
   UQcoouRUdoU/WLm6ZN7sY8UheRq1dcvl0lxsh1l3Hx+9/u7ga8v87DQaK
   eqK4YVx2qS7K2PlqHXu+9TV3gOHy1aa24YM/2S6D7Zy2q7+C/JeEpcm0T
   5TwZwOYabC4Uq4EsMb4gOQLwWYe/JdESjdpVd6AmuIEvDQJPYAhEK/CTV
   5SeIIlomKFEhOmthh8qIGbsskHr8oogxxBiE9hNY3lYYuIotjWgmX8ez9
   uyNCnPSlVqKl1k/gnlU+mDJE/YctHfpri3btrAes6mZDnaQ/1STvaaLBZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="285074740"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="285074740"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 23:39:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="758675617"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Sep 2022 23:39:49 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXzaH-0003Jx-06;
        Tue, 13 Sep 2022 06:39:49 +0000
Date:   Tue, 13 Sep 2022 14:39:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arun R Murthy <arun.r.murthy@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: drivers/gpu/drm/i915/display/intel_display.c:7539:3: error:
 unannotated fall-through between switch labels
Message-ID: <202209131420.hMv94gaL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220906-121942/Arun-R-Murthy/drm-i915-Support-Async-Flip-on-Linear-buffers/20220426-200801
head:   1e44191e6045780c15f33c16961af128c076bd4c
commit: 1e44191e6045780c15f33c16961af128c076bd4c drm/i915: Support Async Flip on Linear buffers
date:   7 days ago
config: i386-randconfig-a011-20220912 (https://download.01.org/0day-ci/archive/20220913/202209131420.hMv94gaL-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1e44191e6045780c15f33c16961af128c076bd4c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220906-121942/Arun-R-Murthy/drm-i915-Support-Async-Flip-on-Linear-buffers/20220426-200801
        git checkout 1e44191e6045780c15f33c16961af128c076bd4c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/display/intel_display.c:7539:3: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
                   case I915_FORMAT_MOD_X_TILED:
                   ^
   drivers/gpu/drm/i915/display/intel_display.c:7539:3: note: insert 'break;' to avoid fall-through
                   case I915_FORMAT_MOD_X_TILED:
                   ^
                   break; 
   1 error generated.


vim +7539 drivers/gpu/drm/i915/display/intel_display.c

b0b2bed2a1305c Ville Syrjälä         2022-02-14  7458  
b0b2bed2a1305c Ville Syrjälä         2022-02-14  7459  static int intel_async_flip_check_hw(struct intel_atomic_state *state, struct intel_crtc *crtc)
30ff93af9e19db Karthik B S           2020-09-21  7460  {
30ff93af9e19db Karthik B S           2020-09-21  7461  	struct drm_i915_private *i915 = to_i915(state->base.dev);
30ff93af9e19db Karthik B S           2020-09-21  7462  	const struct intel_crtc_state *old_crtc_state, *new_crtc_state;
30ff93af9e19db Karthik B S           2020-09-21  7463  	const struct intel_plane_state *new_plane_state, *old_plane_state;
30ff93af9e19db Karthik B S           2020-09-21  7464  	struct intel_plane *plane;
30ff93af9e19db Karthik B S           2020-09-21  7465  	int i;
30ff93af9e19db Karthik B S           2020-09-21  7466  
0826edb6a5e5b3 José Roberto de Souza 2021-10-29  7467  	old_crtc_state = intel_atomic_get_old_crtc_state(state, crtc);
0826edb6a5e5b3 José Roberto de Souza 2021-10-29  7468  	new_crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
0826edb6a5e5b3 José Roberto de Souza 2021-10-29  7469  
b0b2bed2a1305c Ville Syrjälä         2022-02-14  7470  	if (!new_crtc_state->uapi.async_flip)
b0b2bed2a1305c Ville Syrjälä         2022-02-14  7471  		return 0;
b0b2bed2a1305c Ville Syrjälä         2022-02-14  7472  
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7473  	if (!new_crtc_state->hw.active) {
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7474  		drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7475  			    "[CRTC:%d:%s] not active\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7476  			    crtc->base.base.id, crtc->base.name);
30ff93af9e19db Karthik B S           2020-09-21  7477  		return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7478  	}
30ff93af9e19db Karthik B S           2020-09-21  7479  
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7480  	if (intel_crtc_needs_modeset(new_crtc_state)) {
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7481  		drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7482  			    "[CRTC:%d:%s] modeset required\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7483  			    crtc->base.base.id, crtc->base.name);
30ff93af9e19db Karthik B S           2020-09-21  7484  		return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7485  	}
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7486  
30ff93af9e19db Karthik B S           2020-09-21  7487  	if (old_crtc_state->active_planes != new_crtc_state->active_planes) {
30ff93af9e19db Karthik B S           2020-09-21  7488  		drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7489  			    "[CRTC:%d:%s] Active planes cannot be in async flip\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7490  			    crtc->base.base.id, crtc->base.name);
30ff93af9e19db Karthik B S           2020-09-21  7491  		return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7492  	}
30ff93af9e19db Karthik B S           2020-09-21  7493  
30ff93af9e19db Karthik B S           2020-09-21  7494  	for_each_oldnew_intel_plane_in_state(state, plane, old_plane_state,
30ff93af9e19db Karthik B S           2020-09-21  7495  					     new_plane_state, i) {
0826edb6a5e5b3 José Roberto de Souza 2021-10-29  7496  		if (plane->pipe != crtc->pipe)
0826edb6a5e5b3 José Roberto de Souza 2021-10-29  7497  			continue;
0826edb6a5e5b3 José Roberto de Souza 2021-10-29  7498  
30ff93af9e19db Karthik B S           2020-09-21  7499  		/*
2e08437160d1e8 Ville Syrjälä         2022-02-14  7500  		 * Only async flip capable planes should be in the state
2e08437160d1e8 Ville Syrjälä         2022-02-14  7501  		 * if we're really about to ask the hardware to perform
2e08437160d1e8 Ville Syrjälä         2022-02-14  7502  		 * an async flip. We should never get this far otherwise.
30ff93af9e19db Karthik B S           2020-09-21  7503  		 */
2e08437160d1e8 Ville Syrjälä         2022-02-14  7504  		if (drm_WARN_ON(&i915->drm,
2e08437160d1e8 Ville Syrjälä         2022-02-14  7505  				new_crtc_state->do_async_flip && !plane->async_flip))
30ff93af9e19db Karthik B S           2020-09-21  7506  			return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7507  
2e08437160d1e8 Ville Syrjälä         2022-02-14  7508  		/*
2e08437160d1e8 Ville Syrjälä         2022-02-14  7509  		 * Only check async flip capable planes other planes
2e08437160d1e8 Ville Syrjälä         2022-02-14  7510  		 * may be involved in the initial commit due to
2e08437160d1e8 Ville Syrjälä         2022-02-14  7511  		 * the wm0/ddb optimization.
2e08437160d1e8 Ville Syrjälä         2022-02-14  7512  		 *
2e08437160d1e8 Ville Syrjälä         2022-02-14  7513  		 * TODO maybe should track which planes actually
2e08437160d1e8 Ville Syrjälä         2022-02-14  7514  		 * were requested to do the async flip...
2e08437160d1e8 Ville Syrjälä         2022-02-14  7515  		 */
2e08437160d1e8 Ville Syrjälä         2022-02-14  7516  		if (!plane->async_flip)
2e08437160d1e8 Ville Syrjälä         2022-02-14  7517  			continue;
2e08437160d1e8 Ville Syrjälä         2022-02-14  7518  
30ff93af9e19db Karthik B S           2020-09-21  7519  		/*
30ff93af9e19db Karthik B S           2020-09-21  7520  		 * FIXME: This check is kept generic for all platforms.
244dba4cb59637 Lucas De Marchi       2021-07-28  7521  		 * Need to verify this for all gen9 platforms to enable
30ff93af9e19db Karthik B S           2020-09-21  7522  		 * this selectively if required.
30ff93af9e19db Karthik B S           2020-09-21  7523  		 */
30ff93af9e19db Karthik B S           2020-09-21  7524  		switch (new_plane_state->hw.fb->modifier) {
1e44191e604578 Arun R Murthy         2022-09-06  7525  		case DRM_FORMAT_MOD_LINEAR:
1e44191e604578 Arun R Murthy         2022-09-06  7526  			/*
1e44191e604578 Arun R Murthy         2022-09-06  7527  			 * FIXME: Async on Linear buffer is supported on ICL as
1e44191e604578 Arun R Murthy         2022-09-06  7528  			 * but with additional alignment and fbc restrictions
1e44191e604578 Arun R Murthy         2022-09-06  7529  			 * need to be taken care of. These aren't applicable for
1e44191e604578 Arun R Murthy         2022-09-06  7530  			 * gen12+.
1e44191e604578 Arun R Murthy         2022-09-06  7531  			 */
1e44191e604578 Arun R Murthy         2022-09-06  7532  			if (DISPLAY_VER(i915) < 12) {
1e44191e604578 Arun R Murthy         2022-09-06  7533  				drm_dbg_kms(&i915->drm,
1e44191e604578 Arun R Murthy         2022-09-06  7534  					    "[PLANE:%d:%s] Modifier does not support async flips\n",
1e44191e604578 Arun R Murthy         2022-09-06  7535  					    plane->base.base.id, plane->base.name);
1e44191e604578 Arun R Murthy         2022-09-06  7536  				return -EINVAL;
1e44191e604578 Arun R Murthy         2022-09-06  7537  			}
1e44191e604578 Arun R Murthy         2022-09-06  7538  
30ff93af9e19db Karthik B S           2020-09-21 @7539  		case I915_FORMAT_MOD_X_TILED:
30ff93af9e19db Karthik B S           2020-09-21  7540  		case I915_FORMAT_MOD_Y_TILED:
30ff93af9e19db Karthik B S           2020-09-21  7541  		case I915_FORMAT_MOD_Yf_TILED:
072ce4164f973b Stanislav Lisovskiy   2022-01-18  7542  		case I915_FORMAT_MOD_4_TILED:
30ff93af9e19db Karthik B S           2020-09-21  7543  			break;
30ff93af9e19db Karthik B S           2020-09-21  7544  		default:
30ff93af9e19db Karthik B S           2020-09-21  7545  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7546  				    "[PLANE:%d:%s] Modifier does not support async flips\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7547  				    plane->base.base.id, plane->base.name);
30ff93af9e19db Karthik B S           2020-09-21  7548  			return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7549  		}
30ff93af9e19db Karthik B S           2020-09-21  7550  
aaec72ee90bccc Ville Syrjälä         2021-10-18  7551  		if (new_plane_state->hw.fb->format->num_planes > 1) {
aaec72ee90bccc Ville Syrjälä         2021-10-18  7552  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7553  				    "[PLANE:%d:%s] Planar formats do not support async flips\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7554  				    plane->base.base.id, plane->base.name);
aaec72ee90bccc Ville Syrjälä         2021-10-18  7555  			return -EINVAL;
aaec72ee90bccc Ville Syrjälä         2021-10-18  7556  		}
aaec72ee90bccc Ville Syrjälä         2021-10-18  7557  
be6c1dd5ac074d Imre Deak             2021-10-27  7558  		if (old_plane_state->view.color_plane[0].mapping_stride !=
be6c1dd5ac074d Imre Deak             2021-10-27  7559  		    new_plane_state->view.color_plane[0].mapping_stride) {
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7560  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7561  				    "[PLANE:%d:%s] Stride cannot be changed in async flip\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7562  				    plane->base.base.id, plane->base.name);
30ff93af9e19db Karthik B S           2020-09-21  7563  			return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7564  		}
30ff93af9e19db Karthik B S           2020-09-21  7565  
30ff93af9e19db Karthik B S           2020-09-21  7566  		if (old_plane_state->hw.fb->modifier !=
30ff93af9e19db Karthik B S           2020-09-21  7567  		    new_plane_state->hw.fb->modifier) {
30ff93af9e19db Karthik B S           2020-09-21  7568  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7569  				    "[PLANE:%d:%s] Modifier cannot be changed in async flip\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7570  				    plane->base.base.id, plane->base.name);
30ff93af9e19db Karthik B S           2020-09-21  7571  			return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7572  		}
30ff93af9e19db Karthik B S           2020-09-21  7573  
30ff93af9e19db Karthik B S           2020-09-21  7574  		if (old_plane_state->hw.fb->format !=
30ff93af9e19db Karthik B S           2020-09-21  7575  		    new_plane_state->hw.fb->format) {
30ff93af9e19db Karthik B S           2020-09-21  7576  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7577  				    "[PLANE:%d:%s] Pixel format cannot be changed in async flip\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7578  				    plane->base.base.id, plane->base.name);
30ff93af9e19db Karthik B S           2020-09-21  7579  			return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7580  		}
30ff93af9e19db Karthik B S           2020-09-21  7581  
30ff93af9e19db Karthik B S           2020-09-21  7582  		if (old_plane_state->hw.rotation !=
30ff93af9e19db Karthik B S           2020-09-21  7583  		    new_plane_state->hw.rotation) {
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7584  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7585  				    "[PLANE:%d:%s] Rotation cannot be changed in async flip\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7586  				    plane->base.base.id, plane->base.name);
30ff93af9e19db Karthik B S           2020-09-21  7587  			return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7588  		}
30ff93af9e19db Karthik B S           2020-09-21  7589  
30ff93af9e19db Karthik B S           2020-09-21  7590  		if (!drm_rect_equals(&old_plane_state->uapi.src, &new_plane_state->uapi.src) ||
30ff93af9e19db Karthik B S           2020-09-21  7591  		    !drm_rect_equals(&old_plane_state->uapi.dst, &new_plane_state->uapi.dst)) {
30ff93af9e19db Karthik B S           2020-09-21  7592  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7593  				    "[PLANE:%d:%s] Size/co-ordinates cannot be changed in async flip\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7594  				    plane->base.base.id, plane->base.name);
30ff93af9e19db Karthik B S           2020-09-21  7595  			return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7596  		}
30ff93af9e19db Karthik B S           2020-09-21  7597  
30ff93af9e19db Karthik B S           2020-09-21  7598  		if (old_plane_state->hw.alpha != new_plane_state->hw.alpha) {
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7599  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7600  				    "[PLANES:%d:%s] Alpha value cannot be changed in async flip\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7601  				    plane->base.base.id, plane->base.name);
30ff93af9e19db Karthik B S           2020-09-21  7602  			return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7603  		}
30ff93af9e19db Karthik B S           2020-09-21  7604  
30ff93af9e19db Karthik B S           2020-09-21  7605  		if (old_plane_state->hw.pixel_blend_mode !=
30ff93af9e19db Karthik B S           2020-09-21  7606  		    new_plane_state->hw.pixel_blend_mode) {
30ff93af9e19db Karthik B S           2020-09-21  7607  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7608  				    "[PLANE:%d:%s] Pixel blend mode cannot be changed in async flip\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7609  				    plane->base.base.id, plane->base.name);
30ff93af9e19db Karthik B S           2020-09-21  7610  			return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7611  		}
30ff93af9e19db Karthik B S           2020-09-21  7612  
30ff93af9e19db Karthik B S           2020-09-21  7613  		if (old_plane_state->hw.color_encoding != new_plane_state->hw.color_encoding) {
30ff93af9e19db Karthik B S           2020-09-21  7614  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7615  				    "[PLANE:%d:%s] Color encoding cannot be changed in async flip\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7616  				    plane->base.base.id, plane->base.name);
30ff93af9e19db Karthik B S           2020-09-21  7617  			return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7618  		}
30ff93af9e19db Karthik B S           2020-09-21  7619  
30ff93af9e19db Karthik B S           2020-09-21  7620  		if (old_plane_state->hw.color_range != new_plane_state->hw.color_range) {
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7621  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7622  				    "[PLANE:%d:%s] Color range cannot be changed in async flip\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7623  				    plane->base.base.id, plane->base.name);
30ff93af9e19db Karthik B S           2020-09-21  7624  			return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7625  		}
ef6ba31dd38405 Anshuman Gupta        2021-09-24  7626  
ef6ba31dd38405 Anshuman Gupta        2021-09-24  7627  		/* plane decryption is allow to change only in synchronous flips */
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7628  		if (old_plane_state->decrypt != new_plane_state->decrypt) {
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7629  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7630  				    "[PLANE:%d:%s] Decryption cannot be changed in async flip\n",
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7631  				    plane->base.base.id, plane->base.name);
ef6ba31dd38405 Anshuman Gupta        2021-09-24  7632  			return -EINVAL;
30ff93af9e19db Karthik B S           2020-09-21  7633  		}
6b4e414ce8dab7 Ville Syrjälä         2022-02-14  7634  	}
30ff93af9e19db Karthik B S           2020-09-21  7635  
30ff93af9e19db Karthik B S           2020-09-21  7636  	return 0;
30ff93af9e19db Karthik B S           2020-09-21  7637  }
30ff93af9e19db Karthik B S           2020-09-21  7638  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

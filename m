Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1005F4D15
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 02:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJEAg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 20:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJEAg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 20:36:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C68E67450;
        Tue,  4 Oct 2022 17:36:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhwc648gHz4x1V;
        Wed,  5 Oct 2022 11:36:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664930182;
        bh=7Dd6lVLWRMqZXvFr+7B1Yw+Vw82U5FQndxoX76KDl4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iIfX1jnYjhGYpDn5vUIBYQ6UDF0js/RVURK2KeubNpql110lCbnt/MyKJnzmHkraE
         uENvtFiLgWz7pF7nZnMd5GglE/zwGdNhcEel2j+sndqGymGnCNys5Kj3Mv/yXPB8tX
         8EN1aJFBIJqqjuhAo0amnpFviRd9qIiPDD0l1rRUWjgOFqrNvE07gLVNVWKCrTGJFg
         HGOLqq/gLuGwLvJjNvwnfqOkF1s63TmA7Zms1ATtnK5zc3qXVUB0SSHxPW1g/3sUux
         K8xSLQWCFFMyzA4kbP2UjrdgM3wse4mFOYBMTCNaWy1oOqUF98gfVGYYE2dIcMKuEl
         bIFoyLv1S+XoA==
Date:   Wed, 5 Oct 2022 11:36:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20221005113620.4835b6c9@canb.auug.org.au>
In-Reply-To: <20220831090426.0c426d7b@canb.auug.org.au>
References: <20220812081245.380c375f@canb.auug.org.au>
        <20220831090426.0c426d7b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9/MBYmvpAPmluWPesi0MU5N";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9/MBYmvpAPmluWPesi0MU5N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 31 Aug 2022 09:04:26 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> On Fri, 12 Aug 2022 08:13:47 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > After merging the amdgpu tree, today's linux-next build (htmldocs)
> > produced this warning:
> >=20
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'always_scale' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'always_use_regamma' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'aux_wake_wa' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'avoid_vbios_exec_table' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'az_endpoint_mute_only' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'bandwidth_calcs_trace' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'bw_val_profile' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'clock_trace' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'cm_in_bypass' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'crb_alloc_policy' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'crb_alloc_policy_min_disp_count' not described in 'dc_debug_option=
s'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_48mhz_pwrdwn' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_clock_gate' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_dcc' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_dfs_bypass' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_dmcu' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_dpp_power_gate' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_dram_clock_change_vactive_support' not described in 'dc_de=
bug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_dsc' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_dsc_edp' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_dsc_power_gate' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_dtb_ref_clk_switch' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_fams' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_fec' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_fixed_vs_aux_timeout_wa' not described in 'dc_debug_option=
s'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_hubp_power_gate' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_idle_power_optimizations' not described in 'dc_debug_optio=
ns'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_mem_low_power' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_min_fclk' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_pplib_clock_request' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_pplib_wm_range' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_psr' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_stereo_support' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_stutter' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_timing_sync' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_uhbr' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_z10' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'disable_z9_mpc' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'dmcub_emulation' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'dml_disallow_alternate_prefetch_modes' not described in 'dc_debug_=
options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'dml_hostvm_override' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'dmub_command_table' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'dmub_offload_enabled' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'dpia_debug' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'dram_clock_change_latency_ns' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'dsc_bpp_increment_div' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'dsc_min_slice_height_override' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'dwb_fi_phase' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'edid_read_retry_times' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'enable_dmcub_surface_flip' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'enable_dmub_aux_for_legacy_ddc' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'enable_dp_dig_pixel_rate_div_policy' not described in 'dc_debug_op=
tions'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'enable_dram_clock_change_one_display_vactive' not described in 'dc=
_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'enable_driver_sequence_debug' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'enable_mem_low_power' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'enable_single_display_2to1_odm_policy' not described in 'dc_debug_=
options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'enable_sw_cntl_psr' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'enable_tri_buf' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'enable_z9_disable_interface' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'exit_idle_opt_for_cursor_updates' not described in 'dc_debug_optio=
ns'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'extended_blank_optimization' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'fec_enable_delay_in100us' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'fixed_vs_aux_delay_config_wa' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'force_abm_enable' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'force_clock_mode' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'force_disable_subvp' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'force_dp2_lt_fallback_method' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'force_dsc_edp_policy' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'force_fclk_khz' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'force_min_dcfclk_mhz' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'force_odm_combine' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'force_odm_combine_4to1' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'force_single_disp_pipe_split' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'force_subvp_mclk_switch' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'force_usr_allow' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'force_vblank_alignment' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'hdmi20_disable' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'hpo_optimization' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'ignore_cable_id' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'legacy_dp2_lt' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'mall_additional_timer_percent' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'mall_error_as_fatal' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'mall_size_override' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'max_disp_clk' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'max_downscale_src_width' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'min_disp_clk_khz' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'min_dpp_clk_khz' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'min_dram_clk_khz' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'mst_start_top_delay' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'native422_support' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'optimize_edp_link_rate' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'optimized_watermark' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'percent_of_ideal_drambw' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'performance_trace' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'pplib_wm_report_mode' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'psr_power_use_phy_fsm' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'pstate_enabled' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'recovery_enabled' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'root_clock_optimization' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'sanity_checks' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'scl_reset_length10' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'seamless_boot_odm_combine' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'set_mst_en_for_sst' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'skip_detection_link_training' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'sr_enter_plus_exit_time_dpm0_ns' not described in 'dc_debug_option=
s'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'sr_enter_plus_exit_time_ns' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'sr_exit_time_dpm0_ns' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'sr_exit_time_ns' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'surface_trace' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'timing_trace' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'underflow_assert_delay_us' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'urgent_latency_ns' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'usbc_combo_phy_reset_wa' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'use_legacy_soc_bb_mechanism' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'use_max_lb' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'validate_dml_output' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'validation_trace' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'visual_confirm' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'visual_confirm_rect_height' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'voltage_align_fclk' not described in 'dc_debug_options'
> > drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or=
 member 'vsr_support' not described in 'dc_debug_options'
> >=20
> > Introduced by commit
> >=20
> >   a2b3b9d57bdb ("drm/amd/display: Document pipe split policy") =20
>=20
> I am still seeing these warnings.

That is now commit

  ea76895ffab1 ("drm/amd/display: Document pipe split policy")

in the drm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/9/MBYmvpAPmluWPesi0MU5N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM80YUACgkQAVBC80lX
0Gw4GAf9HBtYR+bJ+alaIxOzw5SXbXqcvjaBJeLhbSv6KrSQ5PiR3VYDoPXVuCUE
UKDOvy7sHzz2jvKBhpvcsX8H+GAIYMmXQ5QsCTDfnY96+BnBv8ESEJdS9BnzngUe
umaw/FUDQLj3lZ5c2eLq+sxy4gDsOru/rV83e18XsGO+FwvQest97sJxF/s/iLc+
Jvio0m0q+26xc4jhMnWb6kt8UHAWfDb/OVhfUfQ3O3M0sHmz5CcPrxeSHASlcEKJ
5htU+9A6IMcECR/+QeXPA24hup2rHoIpA6DUyuiAD285L0vyKClVMH/tA+Ls6AG9
AxwH5OkmCA2mw6WrMaSvMr3zJV858g==
=MjDZ
-----END PGP SIGNATURE-----

--Sig_/9/MBYmvpAPmluWPesi0MU5N--

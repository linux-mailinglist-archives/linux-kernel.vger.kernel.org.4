Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A656FC741
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjEIM6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjEIM6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:58:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0618D30DE
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 752C46467D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844D6C433D2;
        Tue,  9 May 2023 12:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683637121;
        bh=3Fh9WArHaMt88X9J653cBBj7vWD50mo9lG6KtFjGTjI=;
        h=From:To:Cc:Subject:Date:From;
        b=gMcX3bkYSFUQanUmW4kVoaz2uPgRcHd5BG+j9c60ufY/LcvgxyGOErkWzcWNBjm4S
         4T93h0ooCIE/gZRdStTid8uDbCpzdEWY62/zs2jyg9cC765S3Qlv6wzmlZlvzDg7RD
         RM2yaFjS8dLJX0rXF5UYltOeyQhGe4MGJRem8UFRFLHm6iY6lQoy3JZSAxp38OV68y
         z3I10gRh8u0Mn1LXl9NNICVDVra0mQaqt14jkLrLqf+owQ2eI1mJGAghaB1Ktz53Vv
         foxSYN6cD5dfIWw58x7L8ok/Rw3IDFq/brcluEmfQ//9gd0pjbFU8Y5akvfrXhTUH/
         Hd15E+1lMMF9w==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH 1/2] clang-format: Update with v6.4-rc1's  macro list
Date:   Tue,  9 May 2023 14:58:11 +0200
Message-Id: <20230509125812.310307-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-run the shell fragment that generated the original list.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 .clang-format | 65 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/.clang-format b/.clang-format
index 0d1ed8776733..20969c66fec7 100644
--- a/.clang-format
+++ b/.clang-format
@@ -82,11 +82,16 @@ ForEachMacros:
   - '__for_each_thread'
   - '__hlist_for_each_rcu'
   - '__map__for_each_symbol_by_name'
+  - '__pci_bus_for_each_res0'
+  - '__pci_bus_for_each_res1'
+  - '__pci_dev_for_each_res0'
+  - '__pci_dev_for_each_res1'
   - '__perf_evlist__for_each_entry'
   - '__perf_evlist__for_each_entry_reverse'
   - '__perf_evlist__for_each_entry_safe'
   - '__rq_for_each_bio'
   - '__shost_for_each_device'
+  - '__sym_for_each'
   - 'apei_estatus_for_each_section'
   - 'ata_for_each_dev'
   - 'ata_for_each_link'
@@ -107,10 +112,11 @@ ForEachMacros:
   - 'bond_for_each_slave_rcu'
   - 'bpf__perf_for_each_map'
   - 'bpf__perf_for_each_map_named'
+  - 'bpf_for_each'
+  - 'bpf_for_each_reg_in_vstate'
   - 'bpf_for_each_spilled_reg'
   - 'bpf_object__for_each_map'
   - 'bpf_object__for_each_program'
-  - 'bpf_object__for_each_safe'
   - 'bpf_perf_object__for_each'
   - 'btree_for_each_safe128'
   - 'btree_for_each_safe32'
@@ -119,6 +125,7 @@ ForEachMacros:
   - 'card_for_each_dev'
   - 'cgroup_taskset_for_each'
   - 'cgroup_taskset_for_each_leader'
+  - 'cpu_aggr_map__for_each_idx'
   - 'cpufreq_for_each_efficient_entry_idx'
   - 'cpufreq_for_each_entry'
   - 'cpufreq_for_each_entry_idx'
@@ -128,11 +135,14 @@ ForEachMacros:
   - 'css_for_each_descendant_post'
   - 'css_for_each_descendant_pre'
   - 'damon_for_each_region'
+  - 'damon_for_each_region_from'
   - 'damon_for_each_region_safe'
   - 'damon_for_each_scheme'
   - 'damon_for_each_scheme_safe'
   - 'damon_for_each_target'
   - 'damon_for_each_target_safe'
+  - 'damos_for_each_filter'
+  - 'damos_for_each_filter_safe'
   - 'data__for_each_file'
   - 'data__for_each_file_new'
   - 'data__for_each_file_start'
@@ -168,16 +178,17 @@ ForEachMacros:
   - 'drm_mm_for_each_node_safe'
   - 'dsa_switch_for_each_available_port'
   - 'dsa_switch_for_each_cpu_port'
+  - 'dsa_switch_for_each_cpu_port_continue_reverse'
   - 'dsa_switch_for_each_port'
   - 'dsa_switch_for_each_port_continue_reverse'
   - 'dsa_switch_for_each_port_safe'
   - 'dsa_switch_for_each_user_port'
+  - 'dsa_tree_for_each_cpu_port'
   - 'dsa_tree_for_each_user_port'
+  - 'dsa_tree_for_each_user_port_continue_reverse'
   - 'dso__for_each_symbol'
   - 'dsos__for_each_with_build_id'
   - 'elf_hash_for_each_possible'
-  - 'elf_section__for_each_rel'
-  - 'elf_section__for_each_rela'
   - 'elf_symtab__for_each_symbol'
   - 'evlist__for_each_cpu'
   - 'evlist__for_each_entry'
@@ -186,12 +197,15 @@ ForEachMacros:
   - 'evlist__for_each_entry_reverse'
   - 'evlist__for_each_entry_safe'
   - 'flow_action_for_each'
+  - 'for_each_acpi_consumer_dev'
   - 'for_each_acpi_dev_match'
   - 'for_each_active_dev_scope'
   - 'for_each_active_drhd_unit'
   - 'for_each_active_iommu'
   - 'for_each_active_route'
   - 'for_each_aggr_pgid'
+  - 'for_each_and_bit'
+  - 'for_each_andnot_bit'
   - 'for_each_available_child_of_node'
   - 'for_each_bench'
   - 'for_each_bio'
@@ -222,10 +236,13 @@ ForEachMacros:
   - 'for_each_compatible_node'
   - 'for_each_component_dais'
   - 'for_each_component_dais_safe'
+  - 'for_each_conduit'
   - 'for_each_console'
   - 'for_each_console_srcu'
   - 'for_each_cpu'
   - 'for_each_cpu_and'
+  - 'for_each_cpu_andnot'
+  - 'for_each_cpu_or'
   - 'for_each_cpu_wrap'
   - 'for_each_dapm_widgets'
   - 'for_each_dedup_cand'
@@ -254,6 +271,7 @@ ForEachMacros:
   - 'for_each_free_mem_range'
   - 'for_each_free_mem_range_reverse'
   - 'for_each_func_rsrc'
+  - 'for_each_gpiochip_node'
   - 'for_each_group_evsel'
   - 'for_each_group_member'
   - 'for_each_hstate'
@@ -272,6 +290,7 @@ ForEachMacros:
   - 'for_each_lru'
   - 'for_each_matching_node'
   - 'for_each_matching_node_and_match'
+  - 'for_each_media_entity_data_link'
   - 'for_each_mem_pfn_range'
   - 'for_each_mem_range'
   - 'for_each_mem_range_rev'
@@ -280,6 +299,8 @@ ForEachMacros:
   - 'for_each_memory'
   - 'for_each_migratetype_order'
   - 'for_each_missing_reg'
+  - 'for_each_mle_subelement'
+  - 'for_each_mod_mem_type'
   - 'for_each_net'
   - 'for_each_net_continue_reverse'
   - 'for_each_net_rcu'
@@ -307,6 +328,7 @@ ForEachMacros:
   - 'for_each_node_with_cpus'
   - 'for_each_node_with_property'
   - 'for_each_nonreserved_multicast_dest_pgid'
+  - 'for_each_numa_hop_mask'
   - 'for_each_of_allnodes'
   - 'for_each_of_allnodes_from'
   - 'for_each_of_cpu_node'
@@ -325,6 +347,7 @@ ForEachMacros:
   - 'for_each_online_cpu'
   - 'for_each_online_node'
   - 'for_each_online_pgdat'
+  - 'for_each_or_bit'
   - 'for_each_path'
   - 'for_each_pci_bridge'
   - 'for_each_pci_dev'
@@ -347,7 +370,6 @@ ForEachMacros:
   - 'for_each_property_of_node'
   - 'for_each_reg'
   - 'for_each_reg_filtered'
-  - 'for_each_registered_fb'
   - 'for_each_requested_gpio'
   - 'for_each_requested_gpio_in_range'
   - 'for_each_reserved_mem_range'
@@ -360,6 +382,7 @@ ForEachMacros:
   - 'for_each_sec'
   - 'for_each_set_bit'
   - 'for_each_set_bit_from'
+  - 'for_each_set_bit_wrap'
   - 'for_each_set_bitrange'
   - 'for_each_set_bitrange_from'
   - 'for_each_set_clump8'
@@ -370,8 +393,8 @@ ForEachMacros:
   - 'for_each_sgtable_dma_sg'
   - 'for_each_sgtable_page'
   - 'for_each_sgtable_sg'
-  - 'for_each_shell_test'
   - 'for_each_sibling_event'
+  - 'for_each_sta_active_link'
   - 'for_each_subelement'
   - 'for_each_subelement_extid'
   - 'for_each_subelement_id'
@@ -379,10 +402,15 @@ ForEachMacros:
   - 'for_each_subsystem'
   - 'for_each_supported_activate_fn'
   - 'for_each_supported_inject_fn'
+  - 'for_each_sym'
   - 'for_each_test'
   - 'for_each_thread'
   - 'for_each_token'
   - 'for_each_unicast_dest_pgid'
+  - 'for_each_valid_link'
+  - 'for_each_vif_active_link'
+  - 'for_each_vma'
+  - 'for_each_vma_range'
   - 'for_each_vsi'
   - 'for_each_wakeup_source'
   - 'for_each_zone'
@@ -391,6 +419,7 @@ ForEachMacros:
   - 'func_for_each_insn'
   - 'fwnode_for_each_available_child_node'
   - 'fwnode_for_each_child_node'
+  - 'fwnode_for_each_parent_node'
   - 'fwnode_graph_for_each_endpoint'
   - 'gadget_for_each_ep'
   - 'genradix_for_each'
@@ -438,14 +467,9 @@ ForEachMacros:
   - 'in_dev_for_each_ifa_rcu'
   - 'in_dev_for_each_ifa_rtnl'
   - 'inet_bind_bucket_for_each'
-  - 'inet_lhash2_for_each_icsk'
-  - 'inet_lhash2_for_each_icsk_continue'
-  - 'inet_lhash2_for_each_icsk_rcu'
-  - 'interval_tree_for_each_double_span'
   - 'interval_tree_for_each_span'
   - 'intlist__for_each_entry'
   - 'intlist__for_each_entry_safe'
-  - 'iopt_for_each_contig_area'
   - 'kcore_copy__for_each_phdr'
   - 'key_for_each'
   - 'key_for_each_safe'
@@ -482,6 +506,7 @@ ForEachMacros:
   - 'list_for_each_from'
   - 'list_for_each_prev'
   - 'list_for_each_prev_safe'
+  - 'list_for_each_rcu'
   - 'list_for_each_safe'
   - 'llist_for_each'
   - 'llist_for_each_entry'
@@ -489,21 +514,27 @@ ForEachMacros:
   - 'llist_for_each_safe'
   - 'map__for_each_symbol'
   - 'map__for_each_symbol_by_name'
-  - 'map_for_each_event'
-  - 'map_for_each_metric'
   - 'maps__for_each_entry'
   - 'maps__for_each_entry_safe'
+  - 'mas_for_each'
   - 'mci_for_each_dimm'
   - 'media_device_for_each_entity'
   - 'media_device_for_each_intf'
   - 'media_device_for_each_link'
   - 'media_device_for_each_pad'
+  - 'media_entity_for_each_pad'
+  - 'media_pipeline_for_each_entity'
+  - 'media_pipeline_for_each_pad'
+  - 'msi_domain_for_each_desc'
   - 'msi_for_each_desc'
+  - 'mt_for_each'
   - 'nanddev_io_for_each_page'
   - 'netdev_for_each_lower_dev'
   - 'netdev_for_each_lower_private'
   - 'netdev_for_each_lower_private_rcu'
   - 'netdev_for_each_mc_addr'
+  - 'netdev_for_each_synced_mc_addr'
+  - 'netdev_for_each_synced_uc_addr'
   - 'netdev_for_each_uc_addr'
   - 'netdev_for_each_upper_dev_rcu'
   - 'netdev_hw_addr_list_for_each'
@@ -528,6 +559,7 @@ ForEachMacros:
   - 'perf_config_sections__for_each_entry'
   - 'perf_config_set__for_each_entry'
   - 'perf_cpu_map__for_each_cpu'
+  - 'perf_cpu_map__for_each_idx'
   - 'perf_evlist__for_each_entry'
   - 'perf_evlist__for_each_entry_reverse'
   - 'perf_evlist__for_each_entry_safe'
@@ -538,8 +570,8 @@ ForEachMacros:
   - 'perf_hpp_list__for_each_sort_list'
   - 'perf_hpp_list__for_each_sort_list_safe'
   - 'perf_pmu__for_each_hybrid_pmu'
-  - 'ping_portaddr_for_each_entry'
-  - 'ping_portaddr_for_each_entry_rcu'
+  - 'perf_pmus__for_each_pmu'
+  - 'perf_tool_event__for_each_event'
   - 'plist_for_each'
   - 'plist_for_each_continue'
   - 'plist_for_each_entry'
@@ -576,6 +608,7 @@ ForEachMacros:
   - 'rq_for_each_segment'
   - 'rq_list_for_each'
   - 'rq_list_for_each_safe'
+  - 'sample_read_group__for_each'
   - 'scsi_for_each_prot_sg'
   - 'scsi_for_each_sg'
   - 'sctp_for_each_hentry'
@@ -583,10 +616,12 @@ ForEachMacros:
   - 'sec_for_each_insn'
   - 'sec_for_each_insn_continue'
   - 'sec_for_each_insn_from'
+  - 'sec_for_each_sym'
   - 'shdma_for_each_chan'
   - 'shost_for_each_device'
   - 'sk_for_each'
   - 'sk_for_each_bound'
+  - 'sk_for_each_bound_bhash2'
   - 'sk_for_each_entry_offset_rcu'
   - 'sk_for_each_from'
   - 'sk_for_each_rcu'
@@ -608,6 +643,8 @@ ForEachMacros:
   - 'tb_property_for_each'
   - 'tcf_act_for_each_action'
   - 'tcf_exts_for_each_action'
+  - 'ttm_resource_manager_for_each_res'
+  - 'twsk_for_each_bound_bhash2'
   - 'udp_portaddr_for_each_entry'
   - 'udp_portaddr_for_each_entry_rcu'
   - 'usb_hub_for_each_child'
-- 
2.40.1


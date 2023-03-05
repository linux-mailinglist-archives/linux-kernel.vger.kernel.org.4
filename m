Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58746AAEFF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 11:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCEKV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 05:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCEKV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 05:21:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD46F74D;
        Sun,  5 Mar 2023 02:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678011686; x=1709547686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TvF/USg8/T1UNoOMjpIERu16+ru5BKaEJar3ExukpWQ=;
  b=EaoaA6TpIzJKp3D/OX3q1QV0nEu7Pcetuzf4/uXluzpKeJskyqmYxLsV
   USEYWu1mTNtzygYpdJ8vwH+NZdI4VBm8LSVDsnl99gjOfSyD4Y4yD21D2
   eMknEd4QTHHQHKUiK+/nFMHcxZgV8rVdR7ek6Sglorerp6/esMEOm3xZb
   wzMKtDjA3UZquitKUAhkO8L4XZAKqcaXxjpAlMNEpN/88jhqLQwMCly8s
   jLBlKQ8rWMvL6LrOtJSTy1G/wsCfJbPhuWAv++I+K10JA6qx30WT+73Gy
   Aj46Uw0S4NB5j8kH0jRYtAwL9JQhn6IU0a6nAT+uvUwQ1M3FOY07uklKs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="336879888"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="336879888"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 02:21:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="921584100"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="921584100"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Mar 2023 02:21:22 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYlUX-0002fW-02;
        Sun, 05 Mar 2023 10:21:21 +0000
Date:   Sun, 5 Mar 2023 18:20:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manish Bhardwaj <bhardwajmanish18@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, acme@kernel.org,
        alexander.shishkin@linux.intel.com, irogers@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH] perf/core: introduced stub APIs for exported APIs
Message-ID: <202303051803.g6sS9VOE-lkp@intel.com>
References: <20230305092759.10754-1-bhardwajmanish18@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305092759.10754-1-bhardwajmanish18@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manish,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on b01fe98d34f3bed944a93bd8119fed80c856fad8]

url:    https://github.com/intel-lab-lkp/linux/commits/Manish-Bhardwaj/perf-core-introduced-stub-APIs-for-exported-APIs/20230305-172840
base:   b01fe98d34f3bed944a93bd8119fed80c856fad8
patch link:    https://lore.kernel.org/r/20230305092759.10754-1-bhardwajmanish18%40gmail.com
patch subject: [PATCH] perf/core: introduced stub APIs for exported APIs
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230305/202303051803.g6sS9VOE-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/abd3574667ce6899f498ffc1be32ade8ac01e4cb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Manish-Bhardwaj/perf-core-introduced-stub-APIs-for-exported-APIs/20230305-172840
        git checkout abd3574667ce6899f498ffc1be32ade8ac01e4cb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303051803.g6sS9VOE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from arch/powerpc/kernel/syscalls.c:19:
   include/linux/perf_event.h:1713:16: error: 'perf_event_sysfs_show' defined but not used [-Werror=unused-function]
    1713 | static ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
         |                ^~~~~~~~~~~~~~~~~~~~~
   include/linux/perf_event.h:1712:13: error: 'perf_pmu_migrate_context' defined but not used [-Werror=unused-function]
    1712 | static void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)         { }
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf_event.h:1704:1: error: 'perf_event_create_kernel_counter' defined but not used [-Werror=unused-function]
    1704 | perf_event_create_kernel_counter(struct perf_event_attr *attr,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/perf_event.h:1702:13: error: 'perf_pmu_unregister' defined but not used [-Werror=unused-function]
    1702 | static void perf_pmu_unregister(struct pmu *pmu)                                        { }
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/perf_event.h:1698:12: error: 'perf_pmu_register' defined but not used [-Werror=unused-function]
    1698 | static int perf_pmu_register(struct pmu *pmu, const char *name, int type)
         |            ^~~~~~~~~~~~~~~~~
   include/linux/perf_event.h:1692:13: error: 'perf_tp_event' defined but not used [-Werror=unused-function]
    1692 | static void perf_tp_event(u16 event_type, u64 count, void *record,
         |             ^~~~~~~~~~~~~
   include/linux/perf_event.h:1691:13: error: 'perf_report_aux_output_id' defined but not used [-Werror=unused-function]
    1691 | static void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)              { }
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf_event.h:1690:13: error: 'perf_unregister_guest_info_callbacks' defined but not used [-Werror=unused-function]
    1690 | static void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs) { }
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf_event.h:1689:13: error: 'perf_register_guest_info_callbacks' defined but not used [-Werror=unused-function]
    1689 | static void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)   { }
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf_event.h:1688:13: error: 'perf_event_update_userpage' defined but not used [-Werror=unused-function]
    1688 | static void perf_event_update_userpage(struct perf_event *event)                        { }
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf_event.h:1683:12: error: 'perf_event_read_value' defined but not used [-Werror=unused-function]
    1683 | static u64 perf_event_read_value(struct perf_event *event,
         |            ^~~~~~~~~~~~~~~~~~~~~
   include/linux/perf_event.h:1682:13: error: 'perf_event_addr_filters_sync' defined but not used [-Werror=unused-function]
    1682 | static void perf_event_addr_filters_sync(struct perf_event *event)              { }
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/perf_pmu_unregister +1702 include/linux/perf_event.h

  1649	
  1650	extern int perf_output_begin(struct perf_output_handle *handle,
  1651				     struct perf_sample_data *data,
  1652				     struct perf_event *event, unsigned int size);
  1653	extern int perf_output_begin_forward(struct perf_output_handle *handle,
  1654					     struct perf_sample_data *data,
  1655					     struct perf_event *event,
  1656					     unsigned int size);
  1657	extern int perf_output_begin_backward(struct perf_output_handle *handle,
  1658					      struct perf_sample_data *data,
  1659					      struct perf_event *event,
  1660					      unsigned int size);
  1661	
  1662	extern void perf_output_end(struct perf_output_handle *handle);
  1663	extern unsigned int perf_output_copy(struct perf_output_handle *handle,
  1664				     const void *buf, unsigned int len);
  1665	extern unsigned int perf_output_skip(struct perf_output_handle *handle,
  1666					     unsigned int len);
  1667	extern long perf_output_copy_aux(struct perf_output_handle *aux_handle,
  1668					 struct perf_output_handle *handle,
  1669					 unsigned long from, unsigned long to);
  1670	extern int perf_swevent_get_recursion_context(void);
  1671	extern void perf_swevent_put_recursion_context(int rctx);
  1672	extern u64 perf_swevent_set_period(struct perf_event *event);
  1673	extern void perf_event_enable(struct perf_event *event);
  1674	extern void perf_event_disable(struct perf_event *event);
  1675	extern void perf_event_disable_local(struct perf_event *event);
  1676	extern void perf_event_disable_inatomic(struct perf_event *event);
  1677	extern void perf_event_task_tick(void);
  1678	extern int perf_event_account_interrupt(struct perf_event *event);
  1679	extern int perf_event_period(struct perf_event *event, u64 value);
  1680	extern u64 perf_event_pause(struct perf_event *event, bool reset);
  1681	#else /* !CONFIG_PERF_EVENTS: */
  1682	static void perf_event_addr_filters_sync(struct perf_event *event)		{ }
  1683	static u64 perf_event_read_value(struct perf_event *event,
  1684					 u64 *enabled, u64 *running)
  1685	{
  1686		return 0;
  1687	}
  1688	static void perf_event_update_userpage(struct perf_event *event)			{ }
  1689	static void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)	{ }
  1690	static void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)	{ }
  1691	static void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)		{ }
  1692	static void perf_tp_event(u16 event_type, u64 count, void *record,
  1693				  int entry_size, struct pt_regs *regs,
  1694				  struct hlist_head *head, int rctx,
  1695				  struct task_struct *task)
  1696	{
  1697	}
  1698	static int perf_pmu_register(struct pmu *pmu, const char *name, int type)
  1699	{
  1700		return -1;
  1701	}
> 1702	static void perf_pmu_unregister(struct pmu *pmu)					{ }
  1703	static struct perf_event *
  1704	perf_event_create_kernel_counter(struct perf_event_attr *attr,
  1705					int cpu,
  1706					struct task_struct *task,
  1707					perf_overflow_handler_t callback,
  1708					void *context)
  1709	{
  1710		return NULL;
  1711	}
  1712	static void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)		{ }
  1713	static ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
  1714				      char *page)
  1715	{
  1716		return -1;
  1717	}
  1718	static inline void *
  1719	perf_aux_output_begin(struct perf_output_handle *handle,
  1720			      struct perf_event *event)				{ return NULL; }
  1721	static inline void
  1722	perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
  1723										{ }
  1724	static inline int
  1725	perf_aux_output_skip(struct perf_output_handle *handle,
  1726			     unsigned long size)				{ return -EINVAL; }
  1727	static inline void *
  1728	perf_get_aux(struct perf_output_handle *handle)				{ return NULL; }
  1729	static inline void
  1730	perf_event_task_migrate(struct task_struct *task)			{ }
  1731	static inline void
  1732	perf_event_task_sched_in(struct task_struct *prev,
  1733				 struct task_struct *task)			{ }
  1734	static inline void
  1735	perf_event_task_sched_out(struct task_struct *prev,
  1736				  struct task_struct *next)			{ }
  1737	static inline int perf_event_init_task(struct task_struct *child,
  1738					       u64 clone_flags)			{ return 0; }
  1739	static inline void perf_event_exit_task(struct task_struct *child)	{ }
  1740	static inline void perf_event_free_task(struct task_struct *task)	{ }
  1741	static inline void perf_event_delayed_put(struct task_struct *task)	{ }
  1742	static inline struct file *perf_event_get(unsigned int fd)	{ return ERR_PTR(-EINVAL); }
  1743	static inline const struct perf_event *perf_get_event(struct file *file)
  1744	{
  1745		return ERR_PTR(-EINVAL);
  1746	}
  1747	static inline const struct perf_event_attr *perf_event_attrs(struct perf_event *event)
  1748	{
  1749		return ERR_PTR(-EINVAL);
  1750	}
  1751	static inline int perf_event_read_local(struct perf_event *event, u64 *value,
  1752						u64 *enabled, u64 *running)
  1753	{
  1754		return -EINVAL;
  1755	}
  1756	static inline void perf_event_print_debug(void)				{ }
  1757	static inline int perf_event_task_disable(void)				{ return -EINVAL; }
  1758	static inline int perf_event_task_enable(void)				{ return -EINVAL; }
  1759	static inline int perf_event_refresh(struct perf_event *event, int refresh)
  1760	{
  1761		return -EINVAL;
  1762	}
  1763	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
